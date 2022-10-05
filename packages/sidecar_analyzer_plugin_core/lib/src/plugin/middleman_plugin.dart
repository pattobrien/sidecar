import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/instrumentation/instrumentation.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/src/protocol/protocol_internal.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../sidecar_analyzer_plugin_core.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/log_delegate/log_delegate.dart';

final middlemanPluginProvider = Provider(MiddlemanPlugin.new);

class MiddlemanPlugin extends plugin.ServerPlugin {
  MiddlemanPlugin(
    this._ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  late plugin.ServerIsolateChannel pluginChannel;
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
    super.start(_ref.read(pluginChannelProvider));
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    //
    for (final context in contextCollection.contexts) {
      // if sidecar is enabled for context then start a plugin in that directory
      delegate
          .sidecarMessage('handling context: ${context.contextRoot.root.path}');
    }
  }

  Future<void> _initializePlugin() async {
    delegate.sidecarMessage('Middleman initialization started...');
    final root = p.join(
        Platform.environment['HOME']!,
        '.dartServer',
        'sidecar_analyzer_plugin',
        'my_analyzed_codebase',
        'sidecar_analyzer_plugin_core');

    final packagesPath = p.join(
        root, 'tools', 'analyzer_plugin', '.dart_tool', 'package_config.json');

    final executionPath =
        p.join(root, 'tools', 'analyzer_plugin', 'bin', 'sidecar.dart');

    pluginChannel = plugin.ServerIsolateChannel.discovered(
      Uri.file(executionPath, windows: Platform.isWindows),
      Uri.file(packagesPath, windows: Platform.isWindows),
      NoopInstrumentationService(),
    );
    await pluginChannel.listen(
      _ref.read(pluginChannelProvider).sendResponse,
      _ref.read(pluginChannelProvider).sendNotification,
      onDone: () => delegate.sidecarMessage('DONE'),
      onError: (error) => delegate.sidecarMessage('ERROR: ${error.toString()}'),
    );

    _ref.read(pluginStreamProvider.stream).listen(_onRequest);
    delegate.sidecarMessage('Middleman initialization completed.');
  }

  Future<void> _start(
    plugin.PluginCommunicationChannel channel,
  ) async {
    await _initializePlugin();
    if (mode.isDebug) await _startWithHotReload(channel);
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        _ref.read(pluginChannelProvider).sendNotification(
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
  }) async {
    throw UnimplementedError();
  }

  /// Compute the response that should be returned for the given [request], or
  /// `null` if the response has already been sent.
  Future<plugin.Response?> _getResponse(
      plugin.Request request, int requestTime) async {
    plugin.ResponseResult? result;
    switch (request.method) {
      // case ANALYSIS_REQUEST_GET_NAVIGATION:
      //   var params = AnalysisGetNavigationParams.fromRequest(request);
      //   result = await handleAnalysisGetNavigation(params);
      //   break;
      // case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
      //   var params = AnalysisHandleWatchEventsParams.fromRequest(request);
      //   result = await handleAnalysisHandleWatchEvents(params);
      //   break;
      case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
        final params = AnalysisSetContextRootsParams.fromRequest(request);
        result = await handleAnalysisSetContextRoots(params);
        break;
      default:
        pluginChannel.sendRequest(request);
        break;
      // case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
      //   var params = AnalysisSetPriorityFilesParams.fromRequest(request);
      //   result = await handleAnalysisSetPriorityFiles(params);
      //   break;
      // case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
      //   var params = AnalysisSetSubscriptionsParams.fromRequest(request);
      //   result = await handleAnalysisSetSubscriptions(params);
      //   break;
      // case ANALYSIS_REQUEST_UPDATE_CONTENT:
      //   var params = AnalysisUpdateContentParams.fromRequest(request);
      //   result = await handleAnalysisUpdateContent(params);
      //   break;
      // case COMPLETION_REQUEST_GET_SUGGESTIONS:
      //   var params = CompletionGetSuggestionsParams.fromRequest(request);
      //   result = await handleCompletionGetSuggestions(params);
      //   break;
      // case EDIT_REQUEST_GET_ASSISTS:
      //   var params = EditGetAssistsParams.fromRequest(request);
      //   result = await handleEditGetAssists(params);
      //   break;
      // case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
      //   var params = EditGetAvailableRefactoringsParams.fromRequest(request);
      //   result = await handleEditGetAvailableRefactorings(params);
      //   break;
      // case EDIT_REQUEST_GET_FIXES:
      //   var params = EditGetFixesParams.fromRequest(request);
      //   result = await handleEditGetFixes(params);
      //   break;
      // case EDIT_REQUEST_GET_REFACTORING:
      //   var params = EditGetRefactoringParams.fromRequest(request);
      //   result = await handleEditGetRefactoring(params);
      //   break;
      // case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
      //   var params = KytheGetKytheEntriesParams.fromRequest(request);
      //   result = await handleKytheGetKytheEntries(params);
      //   break;
      // case PLUGIN_REQUEST_SHUTDOWN:
      //   var params = PluginShutdownParams();
      //   result = await handlePluginShutdown(params);
      //   _channel.sendResponse(result.toResponse(request.id, requestTime));
      //   _channel.close();
      //   return null;
      // case PLUGIN_REQUEST_VERSION_CHECK:
      //   var params = PluginVersionCheckParams.fromRequest(request);
      //   result = await handlePluginVersionCheck(params);
      //   break;
    }
    if (result == null) {
      return plugin.Response(request.id, requestTime,
          error: plugin.RequestErrorFactory.unknownRequest(request.method));
    }
    return result.toResponse(request.id, requestTime);
  }

  bool _isPriorityAnalysisContext(AnalysisContext analysisContext) {
    return priorityPaths.any(analysisContext.contextRoot.isAnalyzed);
  }

  /// The method that is called when a [request] is received from the analysis
  /// server.
  Future<void> _onRequest(plugin.Request request) async {
    var requestTime = DateTime.now().millisecondsSinceEpoch;
    var id = request.id;
    plugin.Response? response;
    try {
      response = await _getResponse(request, requestTime);
    } on plugin.RequestFailure catch (exception) {
      response = plugin.Response(id, requestTime, error: exception.error);
    } catch (exception, stackTrace) {
      response = plugin.Response(id, requestTime,
          error: RequestError(
              RequestErrorCode.PLUGIN_ERROR, exception.toString(),
              stackTrace: stackTrace.toString()));
    }
    if (response != null) {
      _channel.sendResponse(response);
    }
  }

  plugin.PluginCommunicationChannel get _channel =>
      _ref.read(pluginChannelProvider);
}
