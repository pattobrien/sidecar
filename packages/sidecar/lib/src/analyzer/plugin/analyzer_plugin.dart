// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:cli_util/cli_util.dart';
import 'package:hotreloader/hotreloader.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../protocol/constants/constants.dart';
import '../../protocol/protocol.dart';
import '../../utils/byte_store_ext.dart';
import '../../utils/file_paths.dart';
import '../../utils/logger/logger.dart';
import '../options_provider.dart';
import '../results/analysis_results_reporter.dart';
import '../results/results.dart';
import '../server/analyzer_mode.dart';
import '../server/log_delegate.dart';
import 'plugin.dart';
import 'plugin_resource_provider.dart';

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin(this.ref)
      : resourceProvider = ref.read(pluginResourceProvider),
        super(resourceProvider: ref.read(pluginResourceProvider));

  // HotReloader? _reloader;
  final initializationCompleter = Completer<void>();
  final Ref ref;

  @override
  String get name => kSidecarPluginName;

  @override
  String get version => kPluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => kPluginGlobs;

  SidecarAnalyzerMode get mode => ref.read(cliOptionsProvider).mode;

  late final ByteStore _byteStore =
      resourceProvider.createByteStore(kSidecarPluginName);

  @override
  // ignore: overridden_fields
  final OverlayResourceProvider resourceProvider;

  void _log(String msg) =>
      ref.read(logDelegateProvider).sidecarVerboseMessage(msg);

  void _logError(Object e, StackTrace stackTrace) =>
      ref.read(logDelegateProvider).sidecarError(e, stackTrace);

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    Expando();
    _log('END PLUGIN STARTING....');
    _log('# of rules to activate: ${ref.read(ruleConstructorProvider).length}');
    if (mode.isDebug) {
      ref.read(logDelegateProvider).sidecarMessage('STARTING WITH HOT RELOAD');
      _startWithHotReload(channel);
    }
    super.start(channel);
    channel.sendNotification(
      plugin.Notification(kInitializationCompleteMethod, {}),
    );
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    // _reloader = await HotReloader.create(onAfterReload: (c) {
    await HotReloader.create(onAfterReload: (c) {
      final time = DateTime.now();
      final isos = c.reloadReports.keys;
      ref
          .read(logDelegateProvider)
          .sidecarMessage('\n${time.toIso8601String()} RELOADING...\n');
      final events = c.events ?? [];

      final analysisContexts = ref.read(activeContextsProvider);
      for (final analysisContext in analysisContexts) {
        handleAffectedFiles(
          analysisContext: analysisContext,
          paths: events.map((e) => e.path).toList(),
        );
        // for (final localContexts in analysisContext.localDependencyContexts) {
        //   handleAffectedFiles(
        //     analysisContext: localContexts,
        //     paths: events.map((e) => e.path).toList(),
        //   );
        // }
      }

      // for (final event in events) {
      //   switch (event.type) {
      //     case ChangeType.ADD:
      //       // TODO Handle the event.
      //       break;
      //     case ChangeType.MODIFY:
      //       // contentChanged([event.path]);
      //       break;
      //     case ChangeType.REMOVE:
      //       // TODO Handle event.
      //       break;
      //     default:
      //       // Ignore unhandled watch event types.
      //       break;
      //   }
      // }
      // c.events?.map((e) => e.path);
      // if (c.result == HotReloadResult.Succeeded) {
      //   channel.sendNotification(
      //     plugin.Notification(kSidecarHotReloadMethod, {}),
      //   );
      // }
    });
  }

  AnalysisContextCollection? _contextCollection;

  /// Handle an 'analysis.setContextRoots' request.
  ///
  /// Throw a [plugin.RequestFailure] if the request could not be handled.
  @override
  Future<plugin.AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(
    plugin.AnalysisSetContextRootsParams parameters,
  ) async {
    if (mode.isCli || mode.isDebug) {
      // create our own set context handler
      final includedPaths = parameters.roots.map((e) => e.root).toList();
      AnalysisContextCollection? contextCollection;
      runZonedGuarded(
        () {
          contextCollection = AnalysisContextCollectionImpl(
            includedPaths: includedPaths,
            byteStore: _byteStore,
            // resourceProvider:  PhysicalResourceProvider.INSTANCE,
            // sdkPath: sdkPath,
            // fileContentCache: FileContentCache(resourceProvider),
          );
        },
        (e, s) {},
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {},
        ),
      );

      _contextCollection = contextCollection;

      await afterNewContextCollection(
        contextCollection: contextCollection!,
      );
      return plugin.AnalysisSetContextRootsResult();
    } else {
      return super.handleAnalysisSetContextRoots(parameters);
    }
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    _contextCollection = contextCollection;
    try {
      _log('ISOLATE: afterNewContextCollection');

      ref
          .read(allAnalysisContextsProvider.state)
          .update((_) => contextCollection.contexts);

      await super
          .afterNewContextCollection(contextCollection: contextCollection);
      if (mode.isCli) {
        initializationCompleter.complete();
      }
    } catch (e, stackTrace) {
      _logError('afterNewContextCollection err -- $e', stackTrace);
      rethrow;
    }
  }

  // overriden from analyzer_plugin to allow for non-Dart files to be analyzed for changes
  @override
  Future<void> contentChanged(List<String> paths) async {
    final contextCollection = _contextCollection;
    if (contextCollection != null) {
      await _forAnalysisContexts(contextCollection, (analysisContext) async {
        // ignore: prefer_foreach
        for (final path in paths) {
          analysisContext.changeFile(path);
        }
        final affected = await analysisContext.applyPendingFileChanges();

        // sidecar custom implementation to analyze all non-dart files
        final nonDartPathsInContext = paths
            .where((e) => analysisContext.contextRoot.isAnalyzed(e))
            .where((path) => p.extension(path) != '.dart');

        await handleAffectedFiles(
          analysisContext: analysisContext,
          paths: [...affected, ...nonDartPathsInContext],
          // paths: affected,
        );
      });
    }
  }

  Future<void> _forAnalysisContexts(
    AnalysisContextCollection contextCollection,
    Future<void> Function(AnalysisContext analysisContext) f,
  ) async {
    final nonPriorityAnalysisContexts = <AnalysisContext>[];
    for (final analysisContext in contextCollection.contexts) {
      if (_isPriorityAnalysisContext(analysisContext)) {
        await f(analysisContext);
      } else {
        nonPriorityAnalysisContexts.add(analysisContext);
      }
    }

    for (final analysisContext in nonPriorityAnalysisContexts) {
      await f(analysisContext);
    }
  }

  bool _isPriorityAnalysisContext(AnalysisContext analysisContext) {
    return priorityPaths.any(analysisContext.contextRoot.isAnalyzed);
  }

  @override
  Future<void> analyzeFiles({
    required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {
    final activeContexts = ref.read(activeContextsProvider);
    ref.read(logDelegateProvider).sidecarMessage(
        'CHANGEDFILES1 = ${paths.length} ${paths.toList().toString()}');
    if (activeContexts.any((activeContext) =>
        activeContext.activeRoot.root.path ==
        analysisContext.contextRoot.root.path)) {
      // context is valid

      // analyze all files
      await Future.wait(paths.map((path) async {
        try {
          final file = ref.read(analyzedFileFromPath(path));
          if (file.relativePath == kSidecarYaml) {
            ref
                .read(logDelegateProvider)
                .sidecarVerboseMessage('SIDECAR YAML CHANGED');
          }
          ref.refresh(resolvedUnitProvider(file));
          ref.refresh(analysisResultsForFileProvider(file));

          await ref.refresh(analysisResultsReporterProvider(file).future);
        } catch (e, stackTrace) {
          _logError('analyzeFiles ${e.toString()}', stackTrace);
        }
      }));
    }
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {}

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final path = parameters.file;
    final offset = parameters.offset;
    try {
      final analyzedFile = ref.read(analyzedFileFromPath(path));
      final editRequest = EditRequest(offset: offset, file: analyzedFile);
      //TODO: bug, edits are made for multiple files
      final fixes =
          await ref.read(quickFixForRequestProvider(editRequest).future);

      return plugin.EditGetFixesResult(fixes);
    } catch (e, stackTrace) {
      _logError('handleEditGetFixes $path -- $e', stackTrace);
      rethrow;
    }
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    plugin.EditGetAssistsParams parameters,
  ) async {
    try {
      final analyzedFile = ref.read(analyzedFileFromPath(parameters.file));
      final quickAssistRequest = QuickAssistRequest(
        file: analyzedFile,
        offset: parameters.offset,
        length: parameters.length,
      );

      ref.refresh(assistResultsForFileProvider(analyzedFile));
      ref.refresh(assistResultsWithEditsForFileProvider(analyzedFile));
      final results = await ref
          .read(assistResultsForRequestProvider(quickAssistRequest).future);

      final changes = results
          .map((e) => e.toPrioritizedSourceChanges())
          .expand((e) => e)
          .toList();

      return plugin.EditGetAssistsResult(changes);
    } catch (e, stackTrace) {
      _logError('handleEditGetAssists ${parameters.file} -- $e', stackTrace);
      rethrow;
    }
  }

  /// Handle a 'completion.getSuggestions' request.
  ///
  /// Throw a [plugin.RequestFailure] if the request could not be handled.
  @override
  Future<plugin.CompletionGetSuggestionsResult> handleCompletionGetSuggestions(
    plugin.CompletionGetSuggestionsParams parameters,
  ) async {
    final filePath = parameters.file;
    final offset = parameters.offset;
    return plugin.CompletionGetSuggestionsResult(
      -1,
      -1,
      const <plugin.CompletionSuggestion>[],
    );
  }
}

final pluginInitializationProvider =
    FutureProvider.autoDispose<void>((ref) async {
  final plugin = ref.watch(pluginProvider);
  await plugin.initializationCompleter.future;
  final logger = ref.watch(logDelegateProvider);
  final cliOptions = ref.watch(cliOptionsProvider);
  if (cliOptions.mode.isCli) {
    logger as DebuggerLogDelegate;
    logger.dumpResults();
  }
});

final pluginProvider = Provider.autoDispose<SidecarAnalyzerPlugin>(
  SidecarAnalyzerPlugin.new,
  name: 'pluginProvider',
  dependencies: [
    activeContextsProvider,
    quickFixForRequestProvider,
    analyzedFileFromPath,
    allAnalysisContextsProvider,
    logDelegateProvider,
    ruleConstructorProvider,
    cliOptionsProvider,
    pluginResourceProvider,
  ],
);
