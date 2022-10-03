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

import '../application/activated_rules/activated_rules_notifier.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/analysis_context_collection_service/analysis_context_collection_service.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/project_configuration_service/providers.dart';
import 'analyzer_mode.dart';

final pluginProvider = Provider(SidecarAnalyzerPlugin.new);

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin(
    this._ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  final initializationCompleter = Completer<void>();
  final Ref _ref;

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => pluginGlobs;

  SidecarAnalyzerMode get mode => _ref.read(sidecarAnalyzerMode);
  LogDelegateBase get delegate => _ref.read(logDelegateProvider);

  AnalysisContextService getAnalysisContextService(AnalysisContext context) =>
      _ref.read(analysisContextServiceProvider(context));

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    if (mode.isDebug) _startWithHotReload(channel);
    super.start(channel);
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
      delegate.sidecarVerboseMessage('afterNewContextCollection');

      _ref.read(analysisContextCollectionServiceProvider).collection =
          contextCollection;

      await Future.wait(contextCollection.contexts.map<Future<void>>(
        (context) async {
          delegate.sidecarVerboseMessage(
              'initializing context: ${context.contextRoot.root.path}');

          if (!context.isSidecarEnabled) return;

          await _ref
              .read(analysisContextServiceProvider(context))
              .initializeAnalysisContext();

          await _ref
              .read(projectConfigurationServiceProvider(context.contextRoot))
              .parse();

          _ref
              .read(
                  activatedRulesNotifierProvider(context.contextRoot).notifier)
              .initializeRules();

          await _ref
              .read(analysisContextServiceProvider(context))
              .analyzeEntireContext();

          delegate.sidecarVerboseMessage(
              'completed context: ${context.contextRoot.root.path}');
        },
      ));

      delegate.sidecarVerboseMessage('afterNewContextCollection complete');
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
      final context = _ref
          .read(analysisContextCollectionServiceProvider)
          .getContextFromPath(path);

      final fixes = await _ref
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
      final context = _ref
          .read(analysisContextCollectionServiceProvider)
          .getContextFromPath(path);

      final results = await _ref
          .read(analysisContextServiceProvider(context))
          .getCodeAssists(path, offset, length);

      return plugin.EditGetAssistsResult(results.toList());
    } catch (e, stackTrace) {
      delegate.sidecarError('handleEditGetAssists $path -- $e', stackTrace);
      rethrow;
    }
  }
}
