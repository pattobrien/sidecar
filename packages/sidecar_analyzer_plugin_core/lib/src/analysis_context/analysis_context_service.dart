import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:package_config/package_config_types.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import '../analyzed_file/analyzed_file.dart';
import '../analyzed_file/analyzed_file_providers.dart';
import '../analyzed_file/analyzed_file_service.dart';
import '../application/analysis_results/file_report_provider.dart';
import '../application/rules/activated_rules_service.dart';
import '../constants.dart';
import '../plugin/plugin.dart';
import '../plugin/plugin_from_path.dart';
import '../reports/file_stats.dart';
import '../services/log_delegate/log_delegate.dart';
import '../utils/utils.dart';
import '../version.dart';
import 'resolved_unit_service.dart';

class AnalysisContextService {
  AnalysisContextService(
    this.ref, {
    required this.context,
    required this.resolvedUnitService,
  })  : delegate = ref.read(logDelegateProvider),
        channel = ref.read(masterPluginChannelProvider)!,
        root = context.contextRoot;

  final Ref ref;
  final AnalysisContext context;
  final ContextRoot root;

  final PluginCommunicationChannel channel;
  final LogDelegateBase delegate;
  final ResolvedUnitService resolvedUnitService;

  Future<void> get initialization => _completer.future;
  bool get isInitialized => _completer.isCompleted;
  final _completer = Completer<void>();

  late PackageConfig packageConfig;

  bool isValidContext() {
    assert(_packageConfigCompleter.isCompleted, '');
    try {
      if (!context.isSidecarEnabled) return false;
      final pluginPackages = packageConfig.packages
          .firstWhere((element) => element.name == kSidecarPluginName);
      final pluginPackagePubspecFile =
          File(p.join(pluginPackages.root.path, 'pubspec.yaml'));
      final pubOfficialCache = p.join(Platform.environment['HOME']!,
          '.pub-cache', 'hosted', 'pub.dartlang.org');
      final pubHostedCache =
          p.join(Platform.environment['HOME']!, '.pub-cache', 'hosted');
      final pubGitCache =
          p.join(Platform.environment['HOME']!, '.pub-cache', 'git');
      final pubRoot = p.join(Platform.environment['HOME']!, '.pub-cache');
      final isPluginRunningFromPath = ref.read(isPluginFromPath);

      if (p.isWithin(pubOfficialCache, pluginPackagePubspecFile.path)) {
        // plugin package is from pub
        final folderName =
            pluginPackagePubspecFile.parent.uri.pathSegments.last;

        if (folderName == '$kSidecarPluginName-$packageVersion') return true;
      } else if (p.isWithin(pubHostedCache, pluginPackagePubspecFile.path)) {
        //TODO: plugin package is from some other hosted dependency
      } else if (p.isWithin(pubGitCache, pluginPackagePubspecFile.path)) {
        //TODO: plugin package is from git
      } else if (!p.isWithin(pubRoot, pluginPackagePubspecFile.path)) {
        //TODO: not within pub root folder = from path
        if (isPluginRunningFromPath) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
    // check if the plugin is the same version as
  }

  final _packageConfigCompleter = Completer<void>();

  Future<void> _initPackageConfig() async {
    final path = p.join(root.root.path, '.dart_tool', 'package_config.json');
    final contents = await File(path).readAsBytes();
    packageConfig = PackageConfig.parseBytes(contents, root.root.toUri());
    if (!_packageConfigCompleter.isCompleted) {
      _packageConfigCompleter.complete();
    }
  }

  List<AnalyzedFile> get analyzedFiles => root.typedAnalyzedFiles();

  AnalyzedFile analyzedFileFromPath(String path) => AnalyzedFile(root, path);

  Future<void> generateReport() async {
    final reports = analyzedFiles
        .map((file) => ref.read(fileReportProvider(file)).valueOrNull)
        .whereType<FileStats>();
    ref.read(logDelegateProvider).generateReport(reports);
  }

  Future<void> initialize() async {
    if (!context.isSidecarEnabled) return;
    await _initPackageConfig();

    // await Future.wait(analyzedFiles.map((analyzedFile) async {
    //   //TODO: handle non-Dart files
    //   if (!analyzedFile.isDartFile) return;
    //   if (!p.isWithin(context.contextRoot.root.path, analyzedFile.path)) return;

    //   ref.read(annotationsNotifierProvider(analyzedFile).notifier).refresh();
    //   // final ann = ref.read(annotationsNotifierProvider(analyzedFile)).value;
    //   // delegate.sidecarMessage(
    //   //     '${analyzedFile.relativePath} - ${ann?.length} annotations found');
    // }));
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }

  // Future<List<AnalysisError>> getAnalysisResults(
  //   String path,
  // ) async {
  //   final analyzedFile = analyzedFileFromPath(path);
  //   final analysisPath = context.contextRoot.optionsFile?.path;

  //   if (!context.isSidecarEnabled) return [];
  //   if (!p.isWithin(root.root.path, path)) return [];

  //   if (path == analysisPath) {
  //     await ref.read(projectConfigurationServiceProvider(root)).parse();

  //     return ref
  //         .read(projectConfigurationErrorProvider(root))
  //         .map((e) => e.toAnalysisError())
  //         .toList();
  //   }

  //   await ref
  //       .read(analysisNotifierProvider(analyzedFile).notifier)
  //       .refreshAnalysis();

  //   final analysisResults =
  //       ref.read(analysisNotifierProvider(analyzedFile)).value ?? [];

  //   final sortedResults = List<AnalysisResult>.from([...analysisResults])
  //     ..sort((a, b) => a.sourceSpan.location.startLine
  //         .compareTo(b.sourceSpan.location.startLine));

  //   delegate.analysisResults(path, sortedResults);

  //   return sortedResults
  //       .map((result) => result.toAnalysisError())
  //       .whereType<AnalysisError>()
  //       .toList();
  // }

  // Future<List<AnalysisErrorFixes>> getAnalysisErrorFixes(
  //   String path,
  //   int offset,
  // ) async {
  //   final analyzedFile = analyzedFileFromPath(path);

  //   final analysisResults = ref
  //           .read(analysisNotifierProvider(analyzedFile))
  //           .value
  //           ?.where((analysisResult) {
  //         return analysisResult.isWithinOffset(path, offset) &&
  //             analysisResult.rule is LintRule;
  //       }) ??
  //       <AnalysisResult>[];

  //   return Future.wait<AnalysisErrorFixes>(
  //     analysisResults.map(
  //       (e) {
  //         return e.rule.computeSourceChanges(context.currentSession, e).then(
  //           (value) {
  //             return AnalysisErrorFixes(
  //               e.toAnalysisError()!,
  //               fixes: value
  //                   .map((editResult) => editResult.toPrioritizedSourceChange())
  //                   .toList(),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  // Future<Iterable<PrioritizedSourceChange>> getCodeAssists(
  //   String path,
  //   int offset,
  //   int length,
  // ) async {
  //   final analyzedFile = analyzedFileFromPath(path);

  //   if (!context.isSidecarEnabled) return [];
  //   if (!p.isWithin(root.root.path, path)) return [];
  //   if (!analyzedFile.isDartFile) return [];
  //   // if (unit == null)

  //   final codeEditReporter = ErrorReporter(ref, analyzedFile);

  //   final editRules = activatedRules.whereType<CodeEdit>();

  //   // final unit = await ref.read(resolvedUnitProvider(analyzedFile).future);

  //   final computedFixes = await Future.wait(editRules.map((rule) async {
  //     try {
  //       return await codeEditReporter.generateDartFixes(
  //           unit, rule, offset, length);
  //     } catch (e, stackTrace) {
  //       channel.sendError('getCodeAssists error: $e', stackTrace);
  //       return <PrioritizedSourceChange>[];
  //     }
  //   }));

  //   return computedFixes.expand((changes) => changes).toList();
  // }
}

final analysisContextServiceProvider =
    Provider.family<AnalysisContextService, AnalysisContext>(
  (ref, context) {
    final resolvedUnitService = ref.watch(resolvedUnitServiceProvider(context));
    return AnalysisContextService(
      ref,
      context: context,
      resolvedUnitService: resolvedUnitService,
      // analyzedFileService: analyzedFileService,
    );
  },
  dependencies: [
    resolvedUnitServiceProvider,
    logDelegateProvider,
    masterPluginChannelProvider,
    isPluginFromPath,
    fileReportProvider,
  ],
);
