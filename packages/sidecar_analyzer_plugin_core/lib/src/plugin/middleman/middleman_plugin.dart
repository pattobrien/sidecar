// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../../sidecar_analyzer_plugin_core.dart';
import '../../analysis_context/analysis_context_service.dart';
import '../../constants.dart';
import '../../services/log_delegate/log_delegate.dart';
import 'middleman_communication_router.dart';
import 'middleman_server_isolate.dart';

final middlemanPluginProvider = Provider(
  (ref) {
    return MiddlemanPlugin(ref);
  },
  dependencies: [
    masterPluginChannelProvider,
    middlemanServerIsolateProvider,
    registeredAnalysisContexts,
    isCollectionInitializedProvider,
    logDelegateProvider,
    middlemanCommunicationRouterProvider,
    analysisContextServiceProvider,
    sidecarAnalyzerMode,
  ],
);

const middlemanPluginVersion = '0.1.21-dev.11';

class MiddlemanPlugin extends plugin.ServerPlugin {
  MiddlemanPlugin(
    this._pluginRef, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  final initializationCompleter = Completer<void>();
  final Ref _pluginRef;

  @override
  String get name => kSidecarPluginName;

  @override
  String get version => pluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => pluginGlobs;

  SidecarAnalyzerMode get mode => _pluginRef.read(sidecarAnalyzerMode);
  LogDelegateBase get delegate => _pluginRef.read(logDelegateProvider);

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    delegate.sidecarMessage('MIDDLEMAN STARTING....');
    _start(channel);
  }

  Future<void> _start(
    plugin.PluginCommunicationChannel channel,
  ) async {
    if (mode.isDebug) await _startWithHotReload(channel);
    _pluginRef.read(masterPluginChannelProvider).listen(sendRequest);
  }

  void sendRequest(plugin.Request request) {
    if (request.method == plugin.PLUGIN_REQUEST_VERSION_CHECK) {
      _handleVersionRequest(request);
    } else {
      _pluginRef
          .read(middlemanCommunicationRouterProvider)
          .handleServerRequest(request);
      if (request.method == plugin.ANALYSIS_REQUEST_SET_CONTEXT_ROOTS) {
        _handleContextRequest(request);
      }
    }
  }

  Future<void> _handleVersionRequest(plugin.Request request) async {
    final requestTime = DateTime.now().millisecondsSinceEpoch;
    final params = plugin.PluginVersionCheckParams.fromRequest(request);
    final response = await handlePluginVersionCheck(params);
    final id = request.id;
    _pluginRef
        .read(masterPluginChannelProvider)
        .sendResponse(response.toResponse(id, requestTime));
  }

  @override
  Future<void> beforeContextCollectionDispose({
    required AnalysisContextCollection contextCollection,
  }) async {}

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    try {
      _pluginRef.read(isCollectionInitializedProvider.state).state = false;
      _pluginRef.read(middlemanCommunicationRouterProvider).blockAll();
      _pluginRef.read(registeredAnalysisContexts.state).state = <ContextRoot>[];
      await Future.wait(contextCollection.contexts.map((context) async {
        final rootPath = context.contextRoot.root.path;
        delegate
            .sidecarMessage('MIDDLEMAN: setting up context at root: $rootPath');
        final contextService =
            _pluginRef.read(analysisContextServiceProvider(context));
        await contextService.initialize();
        final isValidContext = contextService.isValidContext();
        if (!isValidContext) {
          delegate.sidecarMessage(
              'MIDDLEMAN: this instance of sidecar plugin is not valid for: $rootPath');
          return;
        }
        _pluginRef
            .read(registeredAnalysisContexts.state)
            .update((state) => [...state, context.contextRoot]);
        final serverIsolate = _pluginRef
            .read(middlemanServerIsolateProvider(context.contextRoot));
        if (serverIsolate.doesAlreadyExist()) {
          // delegate.sidecarMessage(
          //     'MIDDLEMAN: server bootstrapper already exists $rootPath');
          // TODO: reset isolate so it can check for any new changes, e.g. to pubspec, analysis options, etc
        }
        // else {
        // delegate.sidecarMessage(
        //     'MIDDLEMAN $rootPath - setting up plugin source files');
        await serverIsolate.setupPluginSourceFiles();
        delegate.sidecarMessage(
            'MIDDLEMAN $rootPath - setup plugin source files completed  - initializing isolate...');
        await serverIsolate.initializeIsolate();
        delegate.sidecarMessage(
            'MIDDLEMAN $rootPath - initializing isolate complete');
        // }
      }));
      final registeredContexts = _pluginRef.read(registeredAnalysisContexts);
      _pluginRef.read(isCollectionInitializedProvider.state).state = true;
      delegate.sidecarMessage(
          'MM: afterNewContextCollection - registered ${registeredContexts.length} contexts');
    } catch (e, stackTrace) {
      delegate.sidecarError(e, stackTrace);
    }
  }

  Future<void> _handleContextRequest(plugin.Request request) async {
    // final requestTime = DateTime.now().millisecondsSinceEpoch;
    final params = plugin.AnalysisSetContextRootsParams.fromRequest(request);
    final result = await handleAnalysisSetContextRoots(params);
    // _ref
    //     .read(masterPluginChannelProvider)
    //     .sendResponse(result.toResponse(request.id, requestTime));
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        _pluginRef
            .read(masterPluginChannelProvider)
            .sendNotification(plugin.Notification('sidecar.auto_reload', {}));
      }
    });
  }

  Future<void> reload() async {
    await _reloader?.reloadCode();
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {}
}
