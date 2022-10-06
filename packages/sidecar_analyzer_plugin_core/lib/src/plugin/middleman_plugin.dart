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
import 'package:analyzer_plugin/protocol/protocol_constants.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:analyzer_plugin/src/protocol/protocol_internal.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../../sidecar_analyzer_plugin_core.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/log_delegate/log_delegate.dart';
import 'context_plugin_provider.dart';

final middlemanPluginProvider = Provider((ref) {
  return MiddlemanPlugin(ref);
});

class MiddlemanPlugin extends plugin.ServerPlugin {
  MiddlemanPlugin(
    this._ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  // late plugin.ServerIsolateChannel pluginChannel;
  late AnalysisContextCollection _collection;
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
    delegate.sidecarMessage('MIDDLEMAN STARTING....');
    _start(channel);
    // super.start(_ref.read(pluginChannelProvider));
  }

  // Future<void> setNewContextCollection(plugin.Request request) async {
  //   //
  //   delegate.sidecarMessage('# contexts: ${_collection.contexts.length}');
  //   for (final context in _collection.contexts) {
  //     // if sidecar is enabled for context then start a plugin in that directory
  //     delegate
  //         .sidecarMessage('handling context: ${context.contextRoot.root.path}');

  //     // if (!context.isSidecarEnabled) return;

  //     pluginChannel.sendRequest(request);
  //   }
  // }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    try {
      _collection = contextCollection;

      return super
          .afterNewContextCollection(contextCollection: contextCollection);
    } catch (e, stackTrace) {
      delegate.sidecarError('afterNewContextCollection err -- $e', stackTrace);
      rethrow;
    }
  }

  Future<void> initializeContextRoots(List<String> rootPaths) async {
    await Future.wait(rootPaths.map((root) async {
      delegate.sidecarMessage('SIDECAR PLUGIN checkin');
      final spinner = _ref.read(serverIsolateSpinnerProvider);
      final doesExist = spinner.doesAlreadyExist();
      if (!doesExist) {
        delegate.sidecarMessage('SIDECAR PLUGIN DOESNT EXIST: $root');
        // copy source files here

      } else {
        delegate.sidecarMessage('SIDECAR PLUGIN EXISTS: $root');
        await spinner.initializeIsolate();
      }
    }));
  }

  Future<void> _start(
    plugin.PluginCommunicationChannel channel,
  ) async {
    if (mode.isDebug) await _startWithHotReload(channel);
    await _ref.read(serverIsolateSpinnerProvider).initializeIsolate();
    _ref.read(masterPluginChannelProvider).listen((request) {
      _ref.read(serverIsolateSpinnerProvider).sendRequest(request);
    });
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        _ref.read(masterPluginChannelProvider).sendNotification(
              plugin.Notification('sidecar.auto_reload', {}),
            );
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

  @override
  Future<void> analyzeFiles({
    required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {}

  void requestRouter(String path, plugin.Request request) {
    final rootPath = _collection.contextFor(path).contextRoot.root.path;
    final spinner = _ref.read(serverIsolateSpinnerProvider);
    spinner.sendRequest(request);
  }

  void requestRouterAllContexts(plugin.Request request) {
    for (final context in _collection.contexts) {
      final spinner = _ref.read(serverIsolateSpinnerProvider);
      spinner.sendRequest(request);
    }
  }

  /// Compute the response that should be returned for the given [request], or
  /// `null` if the response has already been sent.
  Future<void> _getResponse(plugin.Request request, int requestTime) async {
    // plugin.ResponseResult? result;
    switch (request.method) {
      case ANALYSIS_REQUEST_GET_NAVIGATION:
        var params = plugin.AnalysisGetNavigationParams.fromRequest(request);
        requestRouter(params.file, request);
        // result = await handleAnalysisGetNavigation(params);
        break;
      case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
        var params =
            plugin.AnalysisHandleWatchEventsParams.fromRequest(request);
        // result = await handleAnalysisHandleWatchEvents(params);
        requestRouterAllContexts(request);
        break;
      case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
        var params = plugin.AnalysisSetContextRootsParams.fromRequest(request);
        await initializeContextRoots(params.roots.map((e) => e.root).toList());
        requestRouterAllContexts(request);
        break;
      case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
        var params = plugin.AnalysisSetPriorityFilesParams.fromRequest(request);
        requestRouterAllContexts(request);
        break;
      case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
        var params = plugin.AnalysisSetSubscriptionsParams.fromRequest(request);
        // result = await handleAnalysisSetSubscriptions(params);
        requestRouterAllContexts(request);
        break;
      case ANALYSIS_REQUEST_UPDATE_CONTENT:
        var params = plugin.AnalysisUpdateContentParams.fromRequest(request);
        // result = await handleAnalysisUpdateContent(params);
        requestRouterAllContexts(request);
        break;
      case COMPLETION_REQUEST_GET_SUGGESTIONS:
        var params = plugin.CompletionGetSuggestionsParams.fromRequest(request);
        // result = await handleCompletionGetSuggestions(params);
        requestRouterAllContexts(request);
        break;
      case EDIT_REQUEST_GET_ASSISTS:
        var params = plugin.EditGetAssistsParams.fromRequest(request);
        // result = await handleEditGetAssists(params);
        requestRouterAllContexts(request);
        break;
      case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
        var params =
            plugin.EditGetAvailableRefactoringsParams.fromRequest(request);
        // result = await handleEditGetAvailableRefactorings(params);
        requestRouterAllContexts(request);
        break;
      case EDIT_REQUEST_GET_FIXES:
        var params = plugin.EditGetFixesParams.fromRequest(request);
        // result = await handleEditGetFixes(params);
        requestRouterAllContexts(request);
        break;
      case EDIT_REQUEST_GET_REFACTORING:
        var params = plugin.EditGetRefactoringParams.fromRequest(request);
        // result = await handleEditGetRefactoring(params);
        requestRouterAllContexts(request);
        break;
      case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
        var params = plugin.KytheGetKytheEntriesParams.fromRequest(request);
        // result = await handleKytheGetKytheEntries(params);
        requestRouterAllContexts(request);
        break;
      case PLUGIN_REQUEST_SHUTDOWN:
        var params = plugin.PluginShutdownParams();
        final result = await handlePluginShutdown(params);
        _channel.sendResponse(result.toResponse(request.id, requestTime));
        _channel.close();
        requestRouterAllContexts(request);
        break;
      case PLUGIN_REQUEST_VERSION_CHECK:
        var params = plugin.PluginVersionCheckParams.fromRequest(request);
        final result = await handlePluginVersionCheck(params);
        _channel.sendResponse(result.toResponse(request.id, requestTime));
        break;
    }
    // if (result == null) {
    //   return plugin.Response(request.id, requestTime,
    //       error: plugin.RequestErrorFactory.unknownRequest(request.method));
    // }
    // return result.toResponse(request.id, requestTime);
  }

  Future<void> _onRequest(plugin.Request request) async {
    final requestTime = DateTime.now().millisecondsSinceEpoch;
    final id = request.id;
    plugin.Response? response;
    try {
      await _getResponse(request, requestTime);
    } on plugin.RequestFailure catch (exception) {
      response = plugin.Response(id, requestTime, error: exception.error);
    } catch (exception, stackTrace) {
      response = plugin.Response(id, requestTime,
          error: plugin.RequestError(
              plugin.RequestErrorCode.PLUGIN_ERROR, exception.toString(),
              stackTrace: stackTrace.toString()));
    }
  }
  // bool _isPriorityAnalysisContext(AnalysisContext analysisContext) {
  //   return priorityPaths.any(analysisContext.contextRoot.isAnalyzed);
  // }

  // /// The method that is called when a [request] is received from the analysis
  // /// server.
  // Future<void> _onRequest(plugin.Request request) async {
  //   var requestTime = DateTime.now().millisecondsSinceEpoch;
  //   delegate.sidecarMessage('onRequest recieved');
  //   var id = request.id;
  //   plugin.Response? response;
  //   try {
  //     response = await responseParser(request, requestTime);
  //   } on plugin.RequestFailure catch (exception) {
  //     response = plugin.Response(id, requestTime, error: exception.error);
  //   } catch (exception, stackTrace) {
  //     response = plugin.Response(id, requestTime,
  //         error: RequestError(
  //             RequestErrorCode.PLUGIN_ERROR, exception.toString(),
  //             stackTrace: stackTrace.toString()));
  //   }
  //   if (response != null) {
  //     _channel.sendResponse(response);
  //   }
  // }

  plugin.PluginCommunicationChannel get _channel =>
      _ref.read(masterPluginChannelProvider);
}
