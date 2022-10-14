import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_constants.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../sidecar_analyzer_plugin_core.dart';
import '../../protocol/isolate_message.dart';
import '../../protocol/protocol.dart';
import '../middleman.dart';
import 'isolate_details_provider.dart';

final isolateCommunicationServiceProvider =
    Provider<IsolateCommunicationService>(
  (ref) {
    final isolates = ref.watch(isolateDetailsProvider);
    final service = IsolateCommunicationService(ref, isolates: isolates);
    ref.listen<List<IsolateDetails>>(
      isolateDetailsProvider,
      (previous, next) {
        final changedIsolates = next.where((isolate) =>
            previous?.any((element) => isolate != element) ?? false);
        changedIsolates.forEach(service.addIsolateListener);
      },
    );
    return service;
  },
  dependencies: [
    isolateDetailsProvider,
  ],
);

class IsolateCommunicationService {
  IsolateCommunicationService(
    this.ref, {
    required this.isolates,
  });

  final state = <int, MultiIsolateMessage>{};

  final Ref ref;
  final List<IsolateDetails> isolates;

  PluginCommunicationChannel get channel =>
      ref.read(masterPluginChannelProvider);

  void _log(String msg) => ref.read(logDelegateProvider).sidecarMessage(msg);
  void _logError(Object e, StackTrace stackTrace) =>
      ref.read(logDelegateProvider).sidecarError(e, stackTrace);

  void addIsolateListener(IsolateDetails isolate) {
    // setup listeners for isolate responses, middleman communication
    final root = isolate.activeContext.activeRoot;
    isolate.channel.listen(
      (response) => handlePluginResponse(root, response),
      (notif) => handlePluginNotification(isolate, notif),
      onError: (error) => handlePluginError(isolate, error),
      onDone: () => handlePluginDone(isolate),
    );
  }

  void _addNewMessage(MultiIsolateMessage message) {
    //
  }

  void handleServerRequest(
    Request request,
  ) {
    _addNewMessage(MultiIsolateMessage(
      originalRequest: request,
      requests: _parseRequestType(request),
      initialTimestamp: DateTime.now(),
    ));
  }

  void handlePluginResponse(
    ActiveContextRoot root,
    Response response,
  ) {
    final isoResponse = IsolateResponse(response: response, root: root);
    final cachedMessage = state[int.parse(response.id)];

    assert(
        cachedMessage != null, 'response should always have a cached request');

    final newMessage = cachedMessage!
        .copyWith(responses: [...cachedMessage.responses, isoResponse]);
    if (newMessage.isResponseReady) {
      state.remove(newMessage.id);
      _parseAndHandleResponse(newMessage);
    } else {
      state[newMessage.id] = newMessage;
    }
  }

  void handlePluginNotification(
    IsolateDetails details,
    Notification notification,
  ) {
    //TODO: verify that notifications dont need to be aggregated like responses do
    channel.sendNotification(notification);
  }

  void handlePluginError(
    IsolateDetails details,
    dynamic error,
  ) {
    return _log(
        'ISOLATE ERROR: ${details.activeContext.activeRoot.root.path} || $error');
  }

  void handlePluginDone(
    IsolateDetails details,
  ) {
    return _log('ISOLATE DONE: ${details.activeContext.activeRoot.root.path}');
  }

  List<IsolateRequest> _aggregateRequests(
    Request request, {
    String? path,
  }) {
    if (path != null) {
      return isolates
          .where((isolate) => isolate.activeContext.activeRoot.isAnalyzed(path))
          .map((e) => IsolateRequest(
              request: request, root: e.activeContext.activeRoot))
          .toList();
    } else {
      return isolates
          .map((e) => IsolateRequest(
              request: request, root: e.activeContext.activeRoot))
          .toList();
    }
  }

  List<IsolateRequest> _parseRequestType(Request request) {
    switch (request.method) {
      case ANALYSIS_REQUEST_GET_NAVIGATION:
        final params = AnalysisGetNavigationParams.fromRequest(request);
        return _aggregateRequests(request, path: params.file);
      case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
        final params = AnalysisHandleWatchEventsParams.fromRequest(request);
        return isolates
            .map<IsolateRequest?>((isolate) {
              final root = isolate.activeContext.activeRoot;
              final filteredEvents = params.events
                  .where((event) => root.isAnalyzed(event.path))
                  .toList();
              // if no updates for an isolate, then dont send a request at all
              if (filteredEvents.isEmpty) return null;

              final newRequest = AnalysisHandleWatchEventsParams(filteredEvents)
                  .toRequest(request.id);
              return IsolateRequest(request: newRequest, root: root);
            })
            .whereType<IsolateRequest>()
            .toList();
      case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
        final params = AnalysisSetContextRootsParams.fromRequest(request);
        final roots = params.roots;
        final newRoots = roots
            .map((root) => isolates.firstWhere((isolate) =>
                isolate.activeContext.activeRoot.root.path == root.root))
            .map((e) => e.activeContext.activeRoot);
        return newRoots.map((filteredRoot) {
          final root = ContextRoot(filteredRoot.root.path, []);
          final newRequest =
              AnalysisSetContextRootsParams([root]).toRequest(request.id);
          return IsolateRequest(request: newRequest, root: filteredRoot);
        }).toList();
      case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
        final params = AnalysisSetPriorityFilesParams.fromRequest(request);
        final contextFilesEntries =
            isolates.map<MapEntry<ActiveContextRoot, List<String>>>((e) {
          final root = e.activeContext.activeRoot;
          return MapEntry(root, params.files.where(root.isAnalyzed).toList());
        });
        return contextFilesEntries
            .map((contextFilesEntry) =>
                IsolateRequest(request: request, root: contextFilesEntry.key))
            .toList();
      case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
        final params = AnalysisSetSubscriptionsParams.fromRequest(request);
        final subscriptions = params.subscriptions;
        return isolates
            .map<IsolateRequest?>((isolate) {
              final root = isolate.activeContext.activeRoot;
              final filteredSubscriptions = subscriptions.map((sub, files) =>
                  MapEntry(sub, files.where(root.isAnalyzed).toList()));
              // TODO: do we need to not send a request if files arent applicable to a particular isolate?
              final newRequest =
                  AnalysisSetSubscriptionsParams(filteredSubscriptions)
                      .toRequest(request.id);
              return IsolateRequest(request: newRequest, root: root);
            })
            .whereType<IsolateRequest>()
            .toList();
      case ANALYSIS_REQUEST_UPDATE_CONTENT:
        final params = AnalysisUpdateContentParams.fromRequest(request);
        final files = params.files;
        return isolates
            .map<IsolateRequest?>((isolate) {
              final root = isolate.activeContext.activeRoot;
              final filteredFiles =
                  files.entries.where((e) => root.isAnalyzed(e.key));
              // if no updates for an isolate, then dont send a request at all
              if (filteredFiles.isEmpty) return null;

              final newFiles = {
                for (final fileEntry in filteredFiles)
                  fileEntry.key: fileEntry.value
              };

              final newRequest =
                  AnalysisUpdateContentParams(newFiles).toRequest(request.id);
              return IsolateRequest(request: newRequest, root: root);
            })
            .whereType<IsolateRequest>()
            .toList();
      // final newFiles = Map<String, Object>.from(params.files
      //   ..removeWhere((key, value) =>
      //       !details.activeContext.activeRoot.isAnalyzed(key)));
      // final newRequest =
      //     AnalysisUpdateContentParams(newFiles).toRequest(request.id);
      // return _aggregateRequests(newRequest);
      case COMPLETION_REQUEST_GET_SUGGESTIONS:
        final params = CompletionGetSuggestionsParams.fromRequest(request);
        return _aggregateRequests(request, path: params.file);
      case EDIT_REQUEST_GET_ASSISTS:
        final params = EditGetAssistsParams.fromRequest(request);
        return _aggregateRequests(request, path: params.file);
      case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
        final params = EditGetAvailableRefactoringsParams.fromRequest(request);
        return _aggregateRequests(request, path: params.file);
      case EDIT_REQUEST_GET_FIXES:
        final params = EditGetFixesParams.fromRequest(request);
        return _aggregateRequests(request, path: params.file);
      case EDIT_REQUEST_GET_REFACTORING:
        final params = EditGetRefactoringParams.fromRequest(request);
        return _aggregateRequests(request, path: params.file);
      case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
        final params = KytheGetKytheEntriesParams.fromRequest(request);
        return _aggregateRequests(request, path: params.file);
      case PLUGIN_REQUEST_SHUTDOWN:
        return _aggregateRequests(request);
      case PLUGIN_REQUEST_VERSION_CHECK:
        return _aggregateRequests(request);
      default:
        return _aggregateRequests(request);
    }
  }

  void _parseAndHandleResponse(
    MultiIsolateMessage message,
  ) {
    final responses = message.responses;
    final id = message.originalRequest.id;
    final requestTime = message.initialTimestamp.millisecondsSinceEpoch;
    if (responses.any((element) => element.response.error != null)) {
      // TODO: this should instead be handled per request
      channel.sendResponse(responses
          .firstWhere((element) => element.response.error != null)
          .response);
    } else {
      switch (message.originalRequest.method) {
        case ANALYSIS_REQUEST_GET_NAVIGATION:
          final results = responses
              .map((e) => AnalysisGetNavigationResult.fromResponse(e.response));

          final aggregatedResponse = AnalysisGetNavigationResult(
            results.map((e) => e.files).expand((f) => f).toList(),
            results.map((e) => e.targets).expand((f) => f).toList(),
            results.map((e) => e.regions).expand((f) => f).toList(),
          ).toResponse(id, requestTime);

          channel.sendResponse(aggregatedResponse);
          break;
        case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
          final aggregatedResponse =
              AnalysisHandleWatchEventsResult().toResponse(id, requestTime);
          channel.sendResponse(aggregatedResponse);
          break;
        case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
          final response =
              AnalysisSetContextRootsResult().toResponse(id, requestTime);
          // result = await handleAnalysisSetContextRoots(params);
          channel.sendResponse(response);
          break;
        case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
          final response =
              AnalysisSetPriorityFilesResult().toResponse(id, requestTime);
          channel.sendResponse(response);
          break;
        case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
          final response =
              AnalysisSetSubscriptionsResult().toResponse(id, requestTime);
          channel.sendResponse(response);
          break;
        case ANALYSIS_REQUEST_UPDATE_CONTENT:
          final response =
              AnalysisUpdateContentResult().toResponse(id, requestTime);
          channel.sendResponse(response);
          break;
        case COMPLETION_REQUEST_GET_SUGGESTIONS:
          final results = responses.map(
              (e) => CompletionGetSuggestionsResult.fromResponse(e.response));
          //     .toResponse(id, requestTime);
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
          channel.sendResponse(response);
          break;
        case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
          final results = responses.map((e) =>
              EditGetAvailableRefactoringsResult.fromResponse(e.response));
          final response = EditGetAvailableRefactoringsResult(
                  results.map((e) => e.kinds).expand((f) => f).toList())
              .toResponse(id, requestTime);
          channel.sendResponse(response);
          break;
        case EDIT_REQUEST_GET_FIXES:
          final results =
              responses.map((e) => EditGetFixesResult.fromResponse(e.response));
          final response = EditGetFixesResult(
                  results.map((e) => e.fixes).expand((f) => f).toList())
              .toResponse(id, requestTime);
          channel.sendResponse(response);
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
          channel.sendResponse(response);
          break;
        case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
          final results = responses
              .map((e) => KytheGetKytheEntriesResult.fromResponse(e.response));
          final response = KytheGetKytheEntriesResult(
            results.map((e) => e.entries).expand((f) => f).toList(),
            results.map((e) => e.files).expand((f) => f).toList(),
          ).toResponse(id, requestTime);
          channel.sendResponse(response);
          break;
        case PLUGIN_REQUEST_SHUTDOWN:
          final response = PluginShutdownResult().toResponse(id, requestTime);
          channel.sendResponse(response);
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
}
