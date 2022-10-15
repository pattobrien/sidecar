import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_constants.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:collection/collection.dart';

import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../protocol/protocol.dart';
import '../../../utils/logger/logger.dart';
import '../../context/context.dart';
import '../middleman.dart';
import '../middleman_resource_provider.dart';
import 'isolate_message.dart';
import 'multi_isolate_message.dart';

class IsolateCommunicationService {
  IsolateCommunicationService(
    this.ref, {
    required this.resourceProvider,
  });

  final state = <String, MultiIsolateMessage>{};
  final contentFiles = <String>{};
  final isolates = <IsolateDetails>[];

  final Ref ref;
  final ResourceProvider resourceProvider;

  PluginCommunicationChannel get channel =>
      ref.read(masterPluginChannelProvider);

  void _log(String msg) => ref.read(logDelegateProvider).sidecarMessage(msg);
  void _logError(Object e, StackTrace stackTrace) =>
      ref.read(logDelegateProvider).sidecarError(e, stackTrace);

  void addIsolateListener(IsolateDetails isolate) {
    _log('addIsolateListener: context=${isolate.activeRoot.root.shortName}');
    // setup listeners for isolate responses, middleman communication
    final root = isolate.activeRoot;
    isolate.channel.listen(
      (response) => handlePluginResponse(root, response),
      (notif) => handlePluginNotification(isolate, notif),
      onError: (dynamic error) => handlePluginError(isolate, error),
      onDone: () => handlePluginDone(isolate),
    );
    isolates.add(isolate);
  }

  void _addNewMessage(MultiIsolateMessage message) {
    state[message.originalRequest.id] = message;
    for (final request in message.requests) {
      final isolate =
          isolates.firstWhere((element) => element.activeRoot == request.root);
      isolate.channel.sendRequest(request.request);
    }
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
    _log('ISOLATE RESPONSE || ${root.root.shortName} || ${response.toJson()} ');
    final isoResponse = IsolateResponse(response: response, root: root);

    final cachedMessage = state[response.id];

    assert(
        cachedMessage != null, 'response should always have a cached request');

    final newMessage = cachedMessage!
        .copyWith(responses: [...cachedMessage.responses, isoResponse]);
    if (newMessage.isResponseReady) {
      state.remove(newMessage.originalRequest.id);
      _parseAndHandleResponse(newMessage);
    } else {
      state[newMessage.originalRequest.id] = newMessage;
    }
  }

  void handlePluginNotification(
    IsolateDetails details,
    Notification notification,
  ) {
    //TODO: verify that notifications dont need to be aggregated like responses do
    _log(
        'ISOLATE NOTIFICATION || ${details.activeRoot.root.shortName} || ${notification.toJson()} ');
    _parsePluginNotification(details, notification);
  }

  void _parsePluginNotification(
    IsolateDetails details,
    Notification notification,
  ) {
    //
    switch (notification.event) {
      case kInitializationCompleteMethod:
        _handlePluginInitialization(details);
        break;
    }
    channel.sendNotification(notification);
  }

  void _handlePluginInitialization(IsolateDetails isolate) {
    // analysis.setContextRoots
    // analysis.setSubscriptions
    // analysis.updateContent
    // analysis.setPriorityFiles
    const uuid = Uuid();

    final setRootRequest =
        AnalysisSetContextRootsParams([isolate.activeRoot.toPluginContextRoot])
            .toRequest(uuid.v4());
    _addNewMessage(MultiIsolateMessage(
      originalRequest: setRootRequest,
      requests: [
        IsolateRequest(request: setRootRequest, root: isolate.activeRoot)
      ],
      initialTimestamp: DateTime.now(),
    ));
    final updateContentMap = Map.fromEntries(contentFiles.map(
      (e) => MapEntry(e, _getContentForFile(e)),
    ));
    final updateContentRequest =
        AnalysisUpdateContentParams(updateContentMap).toRequest(uuid.v4());
    _addNewMessage(MultiIsolateMessage(
      originalRequest: updateContentRequest,
      requests: [
        IsolateRequest(request: updateContentRequest, root: isolate.activeRoot)
      ],
      initialTimestamp: DateTime.now(),
    ));
  }

  AddContentOverlay _getContentForFile(String path) {
    final file = resourceProvider.getFile(path);
    final content = file.readAsStringSync();
    return AddContentOverlay(content);
  }

  void handlePluginError(
    IsolateDetails details,
    dynamic error,
  ) {
    return _log(
        'ISOLATE ERROR || ${details.activeRoot.root.shortName} || $error');
  }

  void handlePluginDone(
    IsolateDetails details,
  ) {
    return _log('ISOLATE DONE || ${details.activeRoot.root.shortName}');
  }

  List<IsolateRequest> _aggregateRequests(
    Request request, {
    String? path,
  }) {
    // if path is null, we send it to all isolates
    // if path has a value, we send the request to isolates responsible for that path (should only be one isolate)
    if (path != null) {
      return isolates
          .where((isolate) => isolate.activeRoot.isAnalyzed(path))
          .map((e) => IsolateRequest(request: request, root: e.activeRoot))
          .toList();
    } else {
      return isolates
          .map((e) => IsolateRequest(request: request, root: e.activeRoot))
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
              final root = isolate.activeRoot;
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
            .map((root) => isolates.firstWhereOrNull(
                (isolate) => isolate.activeRoot.root.path == root.root))
            .map((e) => e?.activeRoot)
            .whereType<ActiveContextRoot>();
        return newRoots.map((filteredRoot) {
          final newRequest =
              AnalysisSetContextRootsParams([filteredRoot.toPluginContextRoot])
                  .toRequest(request.id);
          return IsolateRequest(request: newRequest, root: filteredRoot);
        }).toList();
      case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
        final params = AnalysisSetPriorityFilesParams.fromRequest(request);
        final contextFilesEntries =
            isolates.map<MapEntry<ActiveContextRoot, List<String>>>((e) {
          final root = e.activeRoot;
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
              final root = isolate.activeRoot;
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
        contentFiles.addAll(files.keys);
        return isolates
            .map<IsolateRequest?>((isolate) {
              final root = isolate.activeRoot;
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

final isolateCommunicationServiceProvider =
    Provider<IsolateCommunicationService>(
  (ref) {
    final resourceProvider = ref.watch(middlemanResourceProvider);
    return IsolateCommunicationService(ref, resourceProvider: resourceProvider);
  },
  name: 'isolateCommunicationServiceProvider',
  dependencies: [
    masterPluginChannelProvider,
    logDelegateProvider,
    middlemanResourceProvider,
  ],
);
