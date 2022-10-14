import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:hotreloader/hotreloader.dart';
import 'package:riverpod/riverpod.dart';

import '../../constants.dart';
import '../../services/services.dart';
import '../analyzer_mode.dart';
import '../protocol/protocol.dart';
import 'active_project/active_project.dart';
import 'analysis/analysis.dart';
import 'analysis/quick_fix_results.dart';
import 'analysis_contexts_provider.dart';
import 'rule_constructors_provider.dart';

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin(
    this.ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  final initializationCompleter = Completer<void>();
  final Ref ref;

  @override
  String get name => kSidecarPluginName;

  @override
  String get version => kPluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => kPluginGlobs;

  SidecarAnalyzerMode get mode => ref.read(sidecarAnalyzerMode);

  void _log(String msg) => ref.read(logDelegateProvider).sidecarMessage(msg);
  void _logError(Object e, StackTrace stackTrace) =>
      ref.read(logDelegateProvider).sidecarError(e, stackTrace);

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    _log('END PLUGIN STARTING....');
    _log('# of rules to activate: ${ref.read(ruleConstructorProvider).length}');
    if (mode.isDebug) _startWithHotReload(channel);
    super.start(channel);
    channel.sendNotification(
      plugin.Notification(kInitializationCompleteMethod, {}),
    );
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        channel.sendNotification(
          plugin.Notification(kSidecarHotReloadMethod, {}),
        );
      }
    });
  }

  Future<void> reload() async {
    await _reloader?.reloadCode();
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    try {
      _log('ISOLATE: afterNewContextCollection');
      // ref.invalidate(activeContextsProvider);
      ref
          .read(allAnalysisContextsProvider.state)
          .update((_) => contextCollection.contexts);

      return super
          .afterNewContextCollection(contextCollection: contextCollection);
    } catch (e, stackTrace) {
      _logError('afterNewContextCollection err -- $e', stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> analyzeFiles({
    required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {
    final allContexts = ref.read(activeContextsProvider);
    if (allContexts.any((activeContext) =>
        activeContext.activeRoot.root.path ==
        analysisContext.contextRoot.root.path)) {
      // context is valid

      // analyze all files
      await Future.wait(paths.map((path) async {
        try {
          final file = ref.read(analyzedFileFromPath(path));
          ref.invalidate(resolvedUnitProvider(file));
          ref.refresh(analysisResultsForFileProvider(file));
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
          length: parameters.length);
      // final context = ref
      //     .read(analysisContextCollectionServiceProvider)
      //     .getContextFromPath(path);

      // final results = await ref
      //     .read(analysisContextServiceProvider(context))
      //     .getCodeAssists(path, offset, length);
      final results = <plugin.PrioritizedSourceChange>[];

      return plugin.EditGetAssistsResult(results.toList());
    } catch (e, stackTrace) {
      _logError('handleEditGetAssists ${parameters.file} -- $e', stackTrace);
      rethrow;
    }
  }
}

final pluginProvider = Provider(
  SidecarAnalyzerPlugin.new,
  name: 'pluginProvider',
  dependencies: [
    analyzedFileFromPath,
    allAnalysisContextsProvider,
    logDelegateProvider,
    ruleConstructorProvider,
    sidecarAnalyzerMode,
  ],
);
