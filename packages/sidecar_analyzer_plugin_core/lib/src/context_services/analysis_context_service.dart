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

  Future<void> initializeAnalysisContext() async {
    if (!context.isSidecarEnabled) return;
    await Future.wait(context.contextRoot.analyzedFiles().map((path) async {
      final analyzedFile = AnalyzedFile(root, path);
      //TODO: handle non-Dart files
      if (!analyzedFile.isDartFile) return;
      if (!p.isWithin(context.contextRoot.root.path, path)) return;

      await ref
          .read(resolvedUnitServiceProvider(analyzedFile))
          .getResolvedUnit();

      ref.read(annotationsNotifierProvider(analyzedFile).notifier).refresh();
    }));
    _completer.complete();
  }

  Future<List<AnalysisErrorFixes>> getAnalysisErrorFixes(
    String path,
    int offset,
  ) async {
    final analyzedFile = AnalyzedFile(root, path);

    // final unit = await ref
    //     .read(resolvedUnitServiceProvider(analyzedFile))
    //     .getResolvedUnit();

    // if (unit == null) throw UnimplementedError();

    final analysisResults = ref
        .read(analysisNotifierProvider(analyzedFile))
        .value
        ?.where((analysisResult) {
      return analysisResult.isWithinOffset(path, offset) &&
          analysisResult.rule is LintRule;
    });

    return await Future.wait<AnalysisErrorFixes>(
      analysisResults?.map(
            (e) {
              return e.rule.computeSourceChanges(e).then(
                (value) {
                  return AnalysisErrorFixes(
                    e.toAnalysisError()!,
                    fixes: value
                        .map((editResult) =>
                            editResult.toPrioritizedSourceChange())
                        .toList(),
                  );
                },
              );
            },
          ) ??
          [],
    );
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

    final sortedResults = analysisResults
      ..sort((a, b) => a.sourceSpan.location.startLine
          .compareTo(b.sourceSpan.location.startLine));

    delegate.analysisResults(path, sortedResults);

    return sortedResults
        .map((result) => result.toAnalysisError())
        .whereType<AnalysisError>()
        .toList();
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

    final unit = await ref
        .read(resolvedUnitServiceProvider(analyzedFile))
        .getResolvedUnit();

    if (unit == null) throw UnimplementedError();

    final computedFixes = await Future.wait(editRules.map((rule) async {
      try {
        return await codeEditReporter.generateDartFixes(
            unit, rule, offset, length);
      } catch (e, stackTrace) {
        channel.sendError('CodeEdit Misc error: $e', stackTrace);
        return <PrioritizedSourceChange>[];
      }
    }));

    return computedFixes.expand((changes) => changes).toList();
  }

  SourceSpan sidecarLintSourceSpan(
    String packageId,
    String lintId,
  ) {
    final contents = ref.read(projectConfigurationProvider(root))!.rawContent;
    final uri = context.contextRoot.root.toUri();
    final doc = loadYamlNode(contents, sourceUrl: uri) as YamlMap;

    final sidecar = doc.nodes['sidecar']! as YamlMap;

    final packages = sidecar.nodes['lints']! as YamlMap;

    final lints = packages.nodes[packageId]! as YamlMap;
    delegate.sidecarVerboseMessage(
        'root ${context.contextRoot.root.path} searching for $packageId - $lintId');

    delegate.sidecarVerboseMessage(
        'nodes ${lints.nodes.entries.map((e) => '${e.key}-${e.value}').toString()}');
    //TODO: is this a dart error?
    final myLintKey = lints.nodes.entries.firstWhere((entry) {
      final isMatch = entry.key.toString() == lintId;
      delegate.sidecarVerboseMessage(
          'node search for $lintId - ${entry.key} ${entry.value} - $isMatch');
      return isMatch;
    }).key as YamlScalar;

    final startOffset = myLintKey.span.start.offset;
    final endOffset = myLintKey.span.end.offset;

    final lineInfo = LineInfo.fromContent(contents);
    final startLocation = lineInfo.getLocation(startOffset);
    final endLocation = lineInfo.getLocation(endOffset);
    final sourceSpan = SourceSpan(
      SourceLocation(
        startOffset,
        column: startLocation.columnNumber,
        line: startLocation.lineNumber,
        sourceUrl: uri,
      ),
      SourceLocation(
        endOffset,
        column: endLocation.columnNumber,
        line: endLocation.lineNumber,
        sourceUrl: uri,
      ),
      contents.substring(startOffset, endOffset),
    );
    return sourceSpan;
  }
}

final analysisContextServiceProvider =
    Provider.family<AnalysisContextService, AnalysisContext>(
        (ref, context) => AnalysisContextService(
              ref,
              context: context,
            ));
