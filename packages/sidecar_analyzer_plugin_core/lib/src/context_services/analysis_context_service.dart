import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart'
    hide ContextRoot;

import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../application/activated_rules/activated_rules_notifier.dart';
import '../application/analysis/analysis_notifier.dart';
import '../application/annotations/file_annotations_notifier.dart';
import '../plugin/plugin.dart';
import '../services/error_reporter/error_reporter.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/project_configuration_service/providers.dart';
import '../services/resolved_unit_service/resolved_unit_service.dart';
import '../utils/channel_extension.dart';
import 'analysis_errors.dart';

class AnalysisContextService {
  AnalysisContextService(
    this.ref, {
    required this.context,
  })  : delegate = ref.read(logDelegateProvider),
        channel = ref.read(pluginChannelProvider)!,
        root = context.contextRoot;

  final Ref ref;
  final AnalysisContext context;
  final ContextRoot root;

  final PluginCommunicationChannel channel;
  final LogDelegateBase delegate;

  Future<void> get initialization => _completer.future;
  bool get isInitialized => _completer.isCompleted;
  final _completer = Completer<void>();

  Map subscriptions = <AnalyzedFile, StreamSubscription>{};

  Future<void> initializeAnalysisContext() async {
    if (!context.isSidecarEnabled) return;
    await Future.wait(context.contextRoot.analyzedFiles().map((path) async {
      final analyzedFile = AnalyzedFile(root, path);
      //TODO: handle non-Dart files
      if (!analyzedFile.isDartFile) return;
      if (!p.isWithin(context.contextRoot.root.path, path)) return;

      subscriptions[analyzedFile] =
          ref.read(resolvedUnitProvider(analyzedFile).stream).listen((event) {
        delegate.sidecarMessage(
            '${analyzedFile.contextRoot.root.shortName}: resolved unit updated for ${analyzedFile.relativePath}');
      });
      await ref
          .read(resolvedUnitServiceProvider(analyzedFile))
          .getResolvedUnit();

      ref.read(annotationsNotifierProvider(analyzedFile).notifier).refresh();
    }));
    _completer.complete();
  }

  Future<List<AnalysisError>> getAnalysisErrors(
    String path,
  ) async {
    final analyzedFile = AnalyzedFile(root, path);
    final rootPath = root.root.path;
    final analysisPath = context.contextRoot.optionsFile?.path;

    if (!context.isSidecarEnabled) return [];
    if (!p.isWithin(rootPath, path)) return [];

    if (path == analysisPath) {
      await ref.watch(projectConfigurationServiceProvider(root)).parse();

      return ref
          .read(projectConfigurationErrorProvider(root))
          .map((e) => e.toAnalysisError())
          .toList();
    }

    await ref
        .read(analysisNotifierProvider(analyzedFile).notifier)
        .refreshAnalysis();

    final analysisResults =
        ref.read(analysisNotifierProvider(analyzedFile)).value ?? [];

    final sortedResults =
        List<AnalysisResult>.from(<AnalysisResult>[...analysisResults])
          ..sort((a, b) => a.sourceSpan.location.startLine
              .compareTo(b.sourceSpan.location.startLine));

    delegate.analysisResults(path, sortedResults);

    return sortedResults
        .map((result) => result.toAnalysisError())
        .whereType<AnalysisError>()
        .toList();
  }

  Future<List<AnalysisErrorFixes>> getAnalysisErrorFixes(
    String path,
    int offset,
  ) async {
    final analyzedFile = AnalyzedFile(root, path);

    final analysisResults = ref
            .read(analysisNotifierProvider(analyzedFile))
            .value
            ?.where((analysisResult) {
          return analysisResult.isWithinOffset(path, offset) &&
              analysisResult.rule is LintRule;
        }) ??
        <AnalysisResult>[];

    return Future.wait<AnalysisErrorFixes>(
      analysisResults.map(
        (e) {
          return e.rule.computeSourceChanges(e).then(
            (value) {
              return AnalysisErrorFixes(
                e.toAnalysisError()!,
                fixes: value
                    .map((editResult) => editResult.toPrioritizedSourceChange())
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }

  Future<Iterable<PrioritizedSourceChange>> getCodeAssists(
    String path,
    int offset,
    int length,
  ) async {
    final analyzedFile = AnalyzedFile(root, path);
    final codeEditReporter = ErrorReporter(ref, analyzedFile);

    final editRules = ref
        .read(activatedRulesNotifierProvider(root))
        .rules
        .whereType<CodeEdit>();

    final unit = ref.read(resolvedUnitProvider(analyzedFile)).value;

    if (unit == null) return [];

    final computedFixes = await Future.wait(editRules.map((rule) async {
      try {
        return await codeEditReporter.generateDartFixes(
            unit, rule, offset, length);
      } catch (e, stackTrace) {
        channel.sendError('getCodeAssists error: $e', stackTrace);
        return <PrioritizedSourceChange>[];
      }
    }));

    return computedFixes.expand((changes) => changes).toList();
  }
}

final analysisContextServiceProvider =
    Provider.family<AnalysisContextService, AnalysisContext>((ref, context) {
  return AnalysisContextService(ref, context: context);
});
