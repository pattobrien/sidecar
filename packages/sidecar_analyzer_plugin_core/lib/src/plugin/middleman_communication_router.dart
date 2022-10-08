import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/channel/channel.dart';

import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_constants.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart'
    hide ContextRoot;

import 'package:riverpod/riverpod.dart';

import '../services/log_delegate/log_delegate.dart';
import 'plugin_channel_provider.dart';

final middlemanCommunicationRouterProvider = Provider((ref) {
  return MiddlemanCommunicationRouter(ref);
});

class MiddlemanCommunicationRouter {
  const MiddlemanCommunicationRouter(this.ref);

  final Ref ref;

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  PluginCommunicationChannel get masterChannel =>
      ref.read(masterPluginChannelProvider);

  void handleServerRequest(
    Request request,
  ) {
    // _onRequest(request);
  }

  void handlePluginResponse(
    ContextRoot root,
    Response response,
  ) {
    //
  }

  void handlePluginDone(ContextRoot root) {
    delegate.sidecarMessage('DONE');
  }

  void handlePluginNotification(
    ContextRoot root,
    Notification notification,
  ) {
    //
  }

  void handlePluginError(
    ContextRoot root,
    dynamic error,
  ) {
    delegate.sidecarMessage('ERROR: ${error.toString()}');
  }

  /// The method that is called when a [request] is received from the analysis
  /// server.
  // Future<void> _onRequest(Request request) async {
  //   final requestTime = DateTime.now().millisecondsSinceEpoch;
  //   final id = request.id;
  //   Response? response;
  //   try {
  //     response = await _getResponse(request, requestTime);
  //   } on RequestFailure catch (exception) {
  //     response = Response(id, requestTime, error: exception.error);
  //   } catch (exception, stackTrace) {
  //     response = Response(id, requestTime,
  //         error: RequestError(
  //             RequestErrorCode.PLUGIN_ERROR, exception.toString(),
  //             stackTrace: stackTrace.toString()));
  //   }
  //   if (response != null) {
  //     masterChannel.sendResponse(response);
  //   }
  // }

  /// Compute the response that should be returned for the given [request], or
  /// `null` if the response has already been sent.
  // Future<Response?> _getResponse(Request request, int requestTime) async {
  //   ResponseResult? result;
  //   switch (request.method) {
  //     case ANALYSIS_REQUEST_GET_NAVIGATION:
  //       var params = AnalysisGetNavigationParams.fromRequest(request);
  //       result = await handleAnalysisGetNavigation(params);
  //       break;
  //     case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
  //       var params = AnalysisHandleWatchEventsParams.fromRequest(request);
  //       result = await handleAnalysisHandleWatchEvents(params);
  //       break;
  //     case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
  //       var params = AnalysisSetContextRootsParams.fromRequest(request);
  //       result = await handleAnalysisSetContextRoots(params);
  //       break;
  //     case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
  //       var params = AnalysisSetPriorityFilesParams.fromRequest(request);
  //       result = await handleAnalysisSetPriorityFiles(params);
  //       break;
  //     case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
  //       var params = AnalysisSetSubscriptionsParams.fromRequest(request);
  //       result = await handleAnalysisSetSubscriptions(params);
  //       break;
  //     case ANALYSIS_REQUEST_UPDATE_CONTENT:
  //       var params = AnalysisUpdateContentParams.fromRequest(request);
  //       result = await handleAnalysisUpdateContent(params);
  //       break;
  //     case COMPLETION_REQUEST_GET_SUGGESTIONS:
  //       var params = CompletionGetSuggestionsParams.fromRequest(request);
  //       result = await handleCompletionGetSuggestions(params);
  //       break;
  //     case EDIT_REQUEST_GET_ASSISTS:
  //       var params = EditGetAssistsParams.fromRequest(request);
  //       result = await handleEditGetAssists(params);
  //       break;
  //     case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
  //       var params = EditGetAvailableRefactoringsParams.fromRequest(request);
  //       result = await handleEditGetAvailableRefactorings(params);
  //       break;
  //     case EDIT_REQUEST_GET_FIXES:
  //       var params = EditGetFixesParams.fromRequest(request);
  //       result = await handleEditGetFixes(params);
  //       break;
  //     case EDIT_REQUEST_GET_REFACTORING:
  //       var params = EditGetRefactoringParams.fromRequest(request);
  //       result = await handleEditGetRefactoring(params);
  //       break;
  //     case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
  //       var params = KytheGetKytheEntriesParams.fromRequest(request);
  //       result = await handleKytheGetKytheEntries(params);
  //       break;
  //     case PLUGIN_REQUEST_SHUTDOWN:
  //       var params = PluginShutdownParams();
  //       result = await handlePluginShutdown(params);
  //       _channel.sendResponse(result.toResponse(request.id, requestTime));
  //       _channel.close();
  //       return null;
  //     case PLUGIN_REQUEST_VERSION_CHECK:
  //       var params = PluginVersionCheckParams.fromRequest(request);
  //       result = await handlePluginVersionCheck(params);
  //       break;
  //   }
  //   if (result == null) {
  //     return Response(request.id, requestTime,
  //         error: RequestErrorFactory.unknownRequest(request.method));
  //   }
  //   return result.toResponse(request.id, requestTime);
  // }

  // bool _isPriorityAnalysisContext(AnalysisContext analysisContext) {
  //   return priorityPaths.any(analysisContext.contextRoot.isAnalyzed);
  // }
}
