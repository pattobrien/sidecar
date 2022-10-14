import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:hotreloader/hotreloader.dart';
import 'package:riverpod/riverpod.dart';

import '../../constants.dart';
import '../../services/services.dart';
import '../analyzer_mode.dart';
import '../protocol/protocol.dart';
import 'analysis/analysis.dart';
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

  void _log(String message) => ref.read(logDelegateProvider).sidecarMessage;
  void _logError(Object e, [StackTrace? stackTrace]) =>
      ref.read(logDelegateProvider).sidecarError;

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
      ref.read(allAnalysisContextsProvider.state).state =
          contextCollection.contexts;

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
    for (final path in paths) {
      final file = ref.read(analyzedFileFromPath(path));
      ref.refresh(resolvedUnitProvider(file));
    }
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    // // TODO: implement analyzeFile
    // throw UnimplementedError();
  }

  // @override
  // Future<plugin.EditGetFixesResult> handleEditGetFixes(
  //   plugin.EditGetFixesParams parameters,
  // ) async {
  //   final path = parameters.file;
  //   final offset = parameters.offset;
  //   try {
  //     final contexts = await ref.read(enabledContextsProvider.future);
  //     final context = contexts
  //         .firstWhere((element) => element.contextRoot.isAnalyzed(path));
  //     final analyzedFile = AnalyzedFile(context.contextRoot, path);
  //     final editRequest = EditRequest(offset: offset, file: analyzedFile);

  //     final fixes =
  //         await ref.read(analysisErrorFixesProvider(editRequest).future);

  //     return plugin.EditGetFixesResult(fixes);
  //   } catch (e, stackTrace) {
  //     delegate.sidecarError('handleEditGetFixes $path -- $e', stackTrace);
  //     rethrow;
  //   }
  // }

  // @override
  // Future<plugin.EditGetAssistsResult> handleEditGetAssists(
  //   plugin.EditGetAssistsParams parameters,
  // ) async {
  //   final path = parameters.file;
  //   final offset = parameters.offset;
  //   final length = parameters.length;
  //   try {
  //     // final context = ref
  //     //     .read(analysisContextCollectionServiceProvider)
  //     //     .getContextFromPath(path);

  //     // final results = await ref
  //     //     .read(analysisContextServiceProvider(context))
  //     //     .getCodeAssists(path, offset, length);
  //     final results = <plugin.PrioritizedSourceChange>[];

  //     return plugin.EditGetAssistsResult(results.toList());
  //   } catch (e, stackTrace) {
  //     delegate.sidecarError('handleEditGetAssists $path -- $e', stackTrace);
  //     rethrow;
  //   }
  // }
}

final pluginProvider = Provider(
  SidecarAnalyzerPlugin.new,
  dependencies: [
    allAnalysisContextsProvider,
    logDelegateProvider,
    ruleConstructorProvider,
    sidecarAnalyzerMode,
  ],
);
