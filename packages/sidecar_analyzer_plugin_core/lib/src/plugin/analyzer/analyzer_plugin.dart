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
import 'package:sidecar/sidecar.dart';

import '../../analysis_context/analysis_context_service.dart';
import '../../analysis_context_collection/analysis_context_collection_notifier.dart';
import '../../analysis_context_collection/enabled_contexts_provider.dart';
import '../../analyzed_file/analyzed_file.dart';
import '../../analyzed_file/analyzed_file_providers.dart';
import '../../analyzed_file/analyzer_plugin_providers.dart';
import '../../analyzed_file/edit_request.dart';
import '../../application/rules/activated_rules_service.dart';
import '../../constants.dart';
import '../../services/log_delegate/log_delegate.dart';
import '../../services/project_configuration_service/providers.dart';
import '../../services/services.dart';
import '../analyzer_mode.dart';

final pluginProvider = Provider(
  SidecarAnalyzerPlugin.new,
  dependencies: [
    activatedRulesProvider,
    analysisErrorsProvider,
    projectConfigurationServiceProvider,
    analysisContextServiceProvider,
    analysisContextsProvider,
    logDelegateProvider,
    ruleConstructorProvider,
    sidecarAnalyzerMode,
  ],
);

const kInitializationCompleteMethod = 'sidecar.init_complete';
const kSidecarHotReloadMethod = 'sidecar.auto_reload';

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
  String get version => pluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => pluginGlobs;

  SidecarAnalyzerMode get mode => ref.read(sidecarAnalyzerMode);
  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  AnalysisContextService getAnalysisContextService(AnalysisContext context) =>
      ref.read(analysisContextServiceProvider(context));

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    delegate.sidecarMessage('END PLUGIN STARTING....');
    delegate.sidecarMessage(
        '# of lints/edits to activate: ${ref.read(ruleConstructorProvider).length} ');
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
      delegate.sidecarMessage('ISOLATE: afterNewContextCollection');

      ref.read(analysisContextsProvider.state).state =
          contextCollection.contexts;

      await Future.wait(contextCollection.contexts.map<Future<void>>(
        (context) async {
          final root = context.contextRoot;
          delegate.sidecarMessage('initializing context: ${root.root.path}');
          // if (!context.isSidecarEnabled) return;
          final contextService =
              ref.read(analysisContextServiceProvider(context));
          await contextService.initialize();
          await ref.read(projectConfigurationServiceProvider(root)).parse();
          await ref.read(activatedRulesProvider(root).future);

          delegate.sidecarMessage('completed context: ${root.root.path}');
        },
      ));

      delegate.sidecarMessage('afterNewContextCollection complete');
      if (!initializationCompleter.isCompleted) {
        initializationCompleter.complete();
      }

      return super
          .afterNewContextCollection(contextCollection: contextCollection);
    } catch (e, stackTrace) {
      delegate.sidecarError('afterNewContextCollection err -- $e', stackTrace);
      rethrow;
    }
  }

  final isAnnotationsInitialized = Completer<void>();

  @override
  Future<void> analyzeFiles({
    required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {
    await super.analyzeFiles(analysisContext: analysisContext, paths: paths);
    final contextService = getAnalysisContextService(analysisContext);
    if (!isAnnotationsInitialized.isCompleted) {
      delegate.sidecarMessage('\n\ninitializing annotations\n');

      await contextService.initialize();
      isAnnotationsInitialized.complete();

      await super.analyzeFiles(analysisContext: analysisContext, paths: paths);

      delegate.sidecarMessage('initializing annotations complete');
    }

    await contextService.generateReport();

    delegate.sidecarMessage('analyzeFiles end');
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    try {
      delegate.sidecarMessage(
          'ISOLATE analyzeFile @ context root ${analysisContext.contextRoot.root.path} - $path  ');
      final analyzedFile = AnalyzedFile(analysisContext.contextRoot, path);
      final results =
          await ref.read(analysisErrorsProvider(analyzedFile).future);
      channel.sendNotification(
          plugin.AnalysisErrorsParams(path, results).toNotification());
    } catch (e, stackTrace) {
      delegate.sidecarError('error analyzing $path -- $e', stackTrace);
      rethrow;
    }
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

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    plugin.EditGetAssistsParams parameters,
  ) async {
    final path = parameters.file;
    final offset = parameters.offset;
    final length = parameters.length;
    try {
      // final context = ref
      //     .read(analysisContextCollectionServiceProvider)
      //     .getContextFromPath(path);

      // final results = await ref
      //     .read(analysisContextServiceProvider(context))
      //     .getCodeAssists(path, offset, length);
      final results = <plugin.PrioritizedSourceChange>[];

      return plugin.EditGetAssistsResult(results.toList());
    } catch (e, stackTrace) {
      delegate.sidecarError('handleEditGetAssists $path -- $e', stackTrace);
      rethrow;
    }
  }
}
