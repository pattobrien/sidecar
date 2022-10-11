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

import '../application/rules/activated_rules_notifier.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/analysis_context_collection_service/analysis_context_collection_service.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/project_configuration_service/providers.dart';
import '../services/services.dart';
import 'analyzer_mode.dart';

final pluginProvider = Provider(SidecarAnalyzerPlugin.new);

const kInitializationCompleteMethod = 'sidecar.init_complete';

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
          plugin.Notification('sidecar.auto_reload', {}),
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
      delegate.sidecarMessage('afterNewContextCollection');

      ref.read(analysisContextCollectionServiceProvider).collection =
          contextCollection;

      await Future.wait(contextCollection.contexts.map<Future<void>>(
        (context) async {
          final root = context.contextRoot;
          delegate.sidecarMessage('initializing context: ${root.root.path}');
          if (!context.isSidecarEnabled) return;
          await ref.read(projectConfigurationServiceProvider(root)).parse();

          ref
              .read(activatedRulesNotifierProvider(root).notifier)
              .initializeRules();

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
    final analysisContextService = getAnalysisContextService(analysisContext);
    if (!isAnnotationsInitialized.isCompleted) {
      delegate.sidecarMessage('\n\ninitializing annotations\n');

      await analysisContextService.initializeAnalysisContext();

      isAnnotationsInitialized.complete();

      await super.analyzeFiles(analysisContext: analysisContext, paths: paths);

      delegate.sidecarMessage('initializing annotations complete');
    }

    await analysisContextService.generateReport();

    delegate.sidecarMessage('analyzeFiles end');
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    try {
      final analysisContextService = getAnalysisContextService(analysisContext);
      await analysisContextService.getAnalysisResults(path);
    } catch (e, stackTrace) {
      delegate.sidecarError('error analyzing $path -- $e', stackTrace);
      rethrow;
    }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final path = parameters.file;
    final offset = parameters.offset;
    try {
      final context = ref
          .read(analysisContextCollectionServiceProvider)
          .getContextFromPath(path);

      final fixes = await ref
          .read(analysisContextServiceProvider(context))
          .getAnalysisErrorFixes(path, offset);

      return plugin.EditGetFixesResult(fixes);
    } catch (e, stackTrace) {
      delegate.sidecarError('handleEditGetFixes $path -- $e', stackTrace);
      rethrow;
    }
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    plugin.EditGetAssistsParams parameters,
  ) async {
    final path = parameters.file;
    final offset = parameters.offset;
    final length = parameters.length;
    try {
      final context = ref
          .read(analysisContextCollectionServiceProvider)
          .getContextFromPath(path);

      final results = await ref
          .read(analysisContextServiceProvider(context))
          .getCodeAssists(path, offset, length);

      return plugin.EditGetAssistsResult(results.toList());
    } catch (e, stackTrace) {
      delegate.sidecarError('handleEditGetAssists $path -- $e', stackTrace);
      rethrow;
    }
  }
}
