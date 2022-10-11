import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer_plugin/channel/channel.dart';

import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_constants.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart'
    hide ContextRoot;

import 'package:riverpod/riverpod.dart';

import '../services/log_delegate/log_delegate.dart';
import 'analyzer_plugin.dart';
import 'middleman_pending_response.dart';
import 'middleman_response.dart';
import 'middleman_server_isolate.dart';
import 'plugin_channel_provider.dart';
import 'root_response.dart';

final middlemanCommunicationRouterProvider = Provider((ref) {
  final router = MiddlemanCommunicationRouter(ref);
  ref.listen<bool>(isCollectionInitializedProvider, (previous, current) {
    if (current == true) {
      router.flushRawRequests();
    }
  });
  return router;
});

final registeredAnalysisContexts =
    StateProvider<List<ContextRoot>>((ref) => <ContextRoot>[]);

final isCollectionInitializedProvider = StateProvider<bool>((ref) => false);

class MiddlemanCommunicationRouter {
  MiddlemanCommunicationRouter(this.ref);

  final Ref ref;
  List<ContextRoot> get contextRoots => ref.read(registeredAnalysisContexts);

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  PluginCommunicationChannel get masterChannel =>
      ref.read(masterPluginChannelProvider);

  Map<ContextRoot, Completer<void>> collectionCompleter = {};

  void blockAll() {
    collectionCompleter = Map<ContextRoot, Completer>.fromIterable(contextRoots
        .map((root) => <ContextRoot, Completer>{root: Completer<void>()}));
  }

  void unblock(ContextRoot root) {
    if (collectionCompleter[root] == null) {
      collectionCompleter[root] = Completer<void>();
    }
    collectionCompleter[root]!.complete();
  }

  Future<void> flushRawRequests() async {
    _rawRequests.sort((a, b) => int.parse(a.id) - int.parse(b.id));
    await Future.wait(contextRoots.map((root) async {
      // await Future.wait(_rawRequests.map((request) async {
      if (collectionCompleter[root] == null) {
        collectionCompleter[root] = Completer<void>();
      }
      //   _registerRequestToQueue(request, root);
      await collectionCompleter[root]!.future;
      // delegate.sidecarMessage('TO PLUGIN: ${request.toJson().toString()}');
      // _onRequest(request, root);
      flushQueuedRequests(root);
      // }));
    }));
    _rawRequests.clear();
  }

  final _rawRequests = <Request>[];
  final Map<ContextRoot, List<Request>> _queuedRequests = {};
  final Map<String, MiddlemanResponse> _pendingResponses = {};
  // final _controller = StreamController<Request>();
  // Stream<Request> get _stream => _controller.stream;

  Future<void> handleServerRequest(
    Request request,
  ) async {
    if (!ref.read(isCollectionInitializedProvider)) {
      _rawRequests.add(request);
    } else {
      await Future.wait(contextRoots.map((contextRoot) async {
        if (collectionCompleter[contextRoot] == null) {
          collectionCompleter[contextRoot] = Completer<void>();
        }
        // _registerRequestToQueue(request, contextRoot);
        await collectionCompleter[contextRoot]!.future;
        flushQueuedRequests(contextRoot);
      }));
      _rawRequests.clear();
      // delegate
      //     .sidecarMessage('TO PLUGIN COMPLETE: ${request.toJson().toString()}');
    }
  }

  void handlePluginResponse(
    ContextRoot root,
    Response response,
  ) {
    // masterChannel.sendResponse(response);
    // _parseResponse();
    delegate.sidecarMessage(
        'PLUGIN: ${root.root.path} - ${response.toJson().toString()}');
    final isComplete = _registerResponse(response, root);
    if (isComplete) {
      delegate.sidecarMessage(
          'MIDDLEMAN: completed request ${response.id} - ${response.toJson().toString()}');
      _parseAndHandleResponse(_pendingResponses[response.id]!);
      _pendingResponses.remove(response.id);
    }
  }

  void handlePluginDone(ContextRoot root) {
    delegate.sidecarMessage('DONE');
  }

  void handlePluginNotification(
    ContextRoot root,
    Notification notification,
  ) {
    if (notification.event == kInitializationCompleteMethod) {
      unblock(root);
    } else {
      masterChannel.sendNotification(notification);
    }
  }

  void handlePluginError(
    ContextRoot root,
    dynamic error,
  ) {
    delegate.sidecarMessage('ERROR: ${error.toString()}');
  }

  void flushQueuedRequests(ContextRoot root) {
    for (final request in _rawRequests) {
      _registerRequestToQueue(request, root);
    }
    var requests = [...?_queuedRequests[root]];
    requests.sort((a, b) => int.parse(a.id) - int.parse(b.id));

    for (final request in requests) {
      delegate.sidecarMessage(
          'TO PLUGIN: ${root.root.path} - ${request.toJson().toString()}');
      // _registerRequestToQueue(request, root);
      _onRequest(request, root);
    }
    _queuedRequests[root] = [];
  }

  /// The method that is called when a [request] is received from the analysis
  /// server.
  void _onRequest(Request request, ContextRoot root) {
    final requestTime = DateTime.now().millisecondsSinceEpoch;
    final id = request.id;
    Response? response;
    try {
      _parseRequestType(request, requestTime, root);
    } on RequestFailure catch (exception) {
      response = Response(id, requestTime, error: exception.error);
    } catch (exception, stackTrace) {
      response = Response(
        id,
        requestTime,
        error: RequestError(
          RequestErrorCode.PLUGIN_ERROR,
          exception.toString(),
          stackTrace: stackTrace.toString(),
        ),
      );
    }
    if (response != null) {
      masterChannel.sendResponse(response);
    }
  }

  void _registerRequestToQueue(
    Request request,
    ContextRoot root,
  ) {
    _queuedRequests[root] = <Request>[...?_queuedRequests[root], request];
    delegate.sidecarMessage(
        'MM: register request ${request.id} for ${root.root.path} - ${request.toJson().toString()}');
    final currentState = _pendingResponses[request.id];
    _pendingResponses[request.id] =
        currentState?.copyWith(roots: [...currentState.roots, root]) ??
            MiddlemanResponse(
              request: request,
              roots: [root],
              responses: [],
              timestamp: DateTime.now(),
            );
  }

  bool _registerResponse(
    Response response,
    ContextRoot root,
  ) {
    final currentState = _pendingResponses[response.id];
    _pendingResponses[response.id] = currentState!.copyWith(responses: [
      ...currentState.responses,
      RootResponse(root: root, response: response)
    ]);

    if (_pendingResponses[response.id]!.roots.length ==
        _pendingResponses[response.id]!.responses.length) {
      return true;
    } else {
      return false;
    }
  }

  void _filteredRequest(
    Request request,
    ContextRoot root, {
    String? path,
  }) {
    if (path != null) {
      if (root.isAnalyzed(path)) {
        final isolate = ref.read(middlemanServerIsolateProvider(root));
        isolate.pluginChannel.sendRequest(request);
        // _registerRequestToQueue(request, root);
      } else {
        // do nothing
      }
    } else {
      final isolate = ref.read(middlemanServerIsolateProvider(root));
      isolate.pluginChannel.sendRequest(request);
      // _registerRequestToQueue(request, root);
    }
  }

  void _parseAndHandleResponse(
    MiddlemanResponse middlemanResponse,
  ) {
    final responses = middlemanResponse.responses;
    final id = middlemanResponse.request.id;
    final requestTime = middlemanResponse.timestamp.millisecondsSinceEpoch;
    if (responses.any((element) => element.response.error != null)) {
      masterChannel.sendResponse(responses
          .firstWhere((element) => element.response.error != null)
          .response);
    } else {
      switch (middlemanResponse.request.method) {
        case ANALYSIS_REQUEST_GET_NAVIGATION:
          final results = responses
              .map((e) => AnalysisGetNavigationResult.fromResponse(e.response));

          final aggregatedResponse = AnalysisGetNavigationResult(
            results.map((e) => e.files).expand((f) => f).toList(),
            results.map((e) => e.targets).expand((f) => f).toList(),
            results.map((e) => e.regions).expand((f) => f).toList(),
          ).toResponse(id, requestTime);

          masterChannel.sendResponse(aggregatedResponse);
          break;
        case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
          final aggregatedResponse =
              AnalysisHandleWatchEventsResult().toResponse(id, requestTime);
          masterChannel.sendResponse(aggregatedResponse);
          break;
        case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
          final response =
              AnalysisSetContextRootsResult().toResponse(id, requestTime);
          // result = await handleAnalysisSetContextRoots(params);
          masterChannel.sendResponse(response);
          break;
        case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
          final response =
              AnalysisSetPriorityFilesResult().toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
          final response =
              AnalysisSetSubscriptionsResult().toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case ANALYSIS_REQUEST_UPDATE_CONTENT:
          final response =
              AnalysisUpdateContentResult().toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case COMPLETION_REQUEST_GET_SUGGESTIONS:
          // TODO complete this request
          // final response =
          //     CompletionGetSuggestionsResult().toResponse(id, requestTime);
          // masterChannel.sendResponse(response);
          break;
        case EDIT_REQUEST_GET_ASSISTS:
          final assistResponses = responses
              .map((e) => EditGetAssistsResult.fromResponse(e.response));
          final response = EditGetAssistsResult(assistResponses
                  .map((e) => e.assists)
                  .expand((f) => f)
                  .toList())
              .toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
          final results = responses.map((e) =>
              EditGetAvailableRefactoringsResult.fromResponse(e.response));
          final response = EditGetAvailableRefactoringsResult(
                  results.map((e) => e.kinds).expand((f) => f).toList())
              .toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case EDIT_REQUEST_GET_FIXES:
          final results =
              responses.map((e) => EditGetFixesResult.fromResponse(e.response));
          final response = EditGetFixesResult(
                  results.map((e) => e.fixes).expand((f) => f).toList())
              .toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case EDIT_REQUEST_GET_REFACTORING:
          final results = responses
              .map((e) => EditGetRefactoringResult.fromResponse(e.response));
          final response = EditGetRefactoringResult(
            results.map((e) => e.initialProblems).expand((f) => f).toList(),
            results.map((e) => e.optionsProblems).expand((f) => f).toList(),
            results.map((e) => e.finalProblems).expand((f) => f).toList(),
            //TODO: compelete the aggregate of this method
            // results.map((e) => e.feedback).expand((f) => f).toList(),
            // results.map((e) => e.change.edits).expand((f) => f).toList(),
          ).toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
          final results = responses
              .map((e) => KytheGetKytheEntriesResult.fromResponse(e.response));
          final response = KytheGetKytheEntriesResult(
            results.map((e) => e.entries).expand((f) => f).toList(),
            results.map((e) => e.files).expand((f) => f).toList(),
          ).toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case PLUGIN_REQUEST_SHUTDOWN:
          final response = PluginShutdownResult().toResponse(id, requestTime);
          masterChannel.sendResponse(response);
          break;
        case PLUGIN_REQUEST_VERSION_CHECK:
          // for (final response in middlemanResponse.responses) {
          //   unblock(response.root);
          // }
          // final response = PluginVersionCheckResult().toResponse(id, requestTime);
          // masterChannel.sendResponse(response);
          //TODO: version check should happen at end plugin level too
          throw UnimplementedError(
              'plugin check should happen at middleman level');

        // break;
      }
    }
  }

  // void _shutdownIsolate(AnalysisContext context) {
  //   // final isolate =
  //   //     ref.read(middlemanServerIsolateProvider(context.contextRoot));
  //   // isolate.shutdown();
  // }

  /// Compute the response that should be returned for the given [request], or
  /// `null` if the response has already been sent.
  void _parseRequestType(
    Request request,
    int requestTime,
    ContextRoot root,
  ) {
    switch (request.method) {
      case ANALYSIS_REQUEST_GET_NAVIGATION:
        final params = AnalysisGetNavigationParams.fromRequest(request);
        _filteredRequest(request, root, path: params.file);
        break;
      case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
        final params = AnalysisHandleWatchEventsParams.fromRequest(request);

        final filteredEvents = params.events
            .where((element) => root.isAnalyzed(element.path))
            .toList();

        final newRequest = AnalysisHandleWatchEventsParams(filteredEvents)
            .toRequest(request.id);

        _filteredRequest(newRequest, root);

        break;
      case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
        final params = AnalysisSetContextRootsParams.fromRequest(request);
        final filteredRoots = params.roots
            .where((contextRoot) => contextRoot.root == root.root.path)
            .toList();
        final newRequest =
            AnalysisSetContextRootsParams(filteredRoots).toRequest(request.id);
        // result = await handleAnalysisSetContextRoots(params);
        _filteredRequest(newRequest, root);
        break;
      case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
        // final params = AnalysisSetPriorityFilesParams.fromRequest(request);
        // result = await handleAnalysisSetPriorityFiles(params);

        _filteredRequest(request, root);
        break;
      case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
        // var params = AnalysisSetSubscriptionsParams.fromRequest(request);
        // result = await handleAnalysisSetSubscriptions(params);
        _filteredRequest(request, root);
        break;
      case ANALYSIS_REQUEST_UPDATE_CONTENT:
        final params = AnalysisUpdateContentParams.fromRequest(request);

        final newFiles = Map<String, Object>.from(params.files)
          ..removeWhere((key, value) => !root.isAnalyzed(key));

        final newRequest =
            AnalysisUpdateContentParams(newFiles).toRequest(request.id);

        _filteredRequest(newRequest, root);
        break;
      case COMPLETION_REQUEST_GET_SUGGESTIONS:
        final params = CompletionGetSuggestionsParams.fromRequest(request);
        // result = await handleCompletionGetSuggestions(params);

        _filteredRequest(request, root, path: params.file);
        break;
      case EDIT_REQUEST_GET_ASSISTS:
        final params = EditGetAssistsParams.fromRequest(request);
        // result = await handleEditGetAssists(params);

        _filteredRequest(request, root, path: params.file);
        break;
      case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
        final params = EditGetAvailableRefactoringsParams.fromRequest(request);
        // result = await handleEditGetAvailableRefactorings(params);
        _filteredRequest(request, root, path: params.file);
        break;
      case EDIT_REQUEST_GET_FIXES:
        final params = EditGetFixesParams.fromRequest(request);
        // result = await handleEditGetFixes(params);
        _filteredRequest(request, root, path: params.file);
        break;
      case EDIT_REQUEST_GET_REFACTORING:
        final params = EditGetRefactoringParams.fromRequest(request);
        // result = await handleEditGetRefactoring(params);
        _filteredRequest(request, root, path: params.file);
        break;
      case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
        final params = KytheGetKytheEntriesParams.fromRequest(request);
        _filteredRequest(request, root, path: params.file);
        break;
      case PLUGIN_REQUEST_SHUTDOWN:
        _filteredRequest(request, root);
        break;
      case PLUGIN_REQUEST_VERSION_CHECK:
        _filteredRequest(request, root);
        break;
      default:
        _filteredRequest(request, root);
        break;
    }
  }
}
