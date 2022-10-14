import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_constants.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
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
  const IsolateCommunicationService(
    this.ref, {
    required this.isolates,
  });

  final Ref ref;
  final List<IsolateDetails> isolates;

  IsolateCommunicationService get pluginChannel =>
      ref.read(isolateCommunicationServiceProvider);

  void addIsolateListener(IsolateDetails isolate) {
    // setup listeners for isolate responses, middleman communication
    isolate.channel.listen(
      (response) => pluginChannel.handlePluginResponse(isolate, response),
      (notif) => pluginChannel.handlePluginNotification(isolate, notif),
      onError: (error) => pluginChannel.handlePluginError(isolate, error),
      onDone: () => pluginChannel.handlePluginDone(isolate),
    );
  }

  void handleServerRequest(
    Request request,
  ) {
    //
  }

  void handlePluginResponse(
    IsolateDetails details,
    Response response,
  ) {
    //
  }
  void handlePluginNotification(
    IsolateDetails details,
    Notification notification,
  ) {
    //
  }

  void handlePluginError(
    IsolateDetails details,
    dynamic error,
  ) {
    //
  }
  void handlePluginDone(
    IsolateDetails details,
  ) {
    //
  }

  void _requestAllIsolates(Request request) {
    for (final isolate in isolates) {
      isolate.channel.sendRequest(request);
    }
  }

  void _requestBuilder<T>({
    required T Function(Request request) fromRequest,
    required void Function(IsolateDetails isolate) handler,
  }) {
    //
  }

  void _requestIndividualIsolate(
    Request request, {
    required String filePath,
  }) {
    //   final isolate = state.firstWhere(
    //       (element) => element.activeContext.activeRoot.isAnalyzed(filePath));
    //   isolate.channel.sendRequest(request);
  }

  void _filteredRequest(
    Request request,
    IsolateDetails isolate, {
    String? path,
  }) {
    if (path != null) {
      if (isolate.activeContext.activeRoot.isAnalyzed(path)) {
        isolate.channel.sendRequest(request);
        // _registerRequestToQueue(request, root);
      } else {
        // do nothing
      }
    } else {
      isolate.channel.sendRequest(request);
      // _registerRequestToQueue(request, root);
    }
  }

  void _parseRequestType(
    Request request,
    int requestTime,
    IsolateDetails details,
  ) {
    switch (request.method) {
      case ANALYSIS_REQUEST_GET_NAVIGATION:
        final params = AnalysisGetNavigationParams.fromRequest(request);
        _filteredRequest(request, details, path: params.file);
        break;
      case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
        final params = AnalysisHandleWatchEventsParams.fromRequest(request);
        final filteredEvents = params.events
            .where((element) =>
                details.activeContext.activeRoot.isAnalyzed(element.path))
            .toList();
        final newRequest = AnalysisHandleWatchEventsParams(filteredEvents)
            .toRequest(request.id);
        _filteredRequest(newRequest, details);
        break;
      case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
        final params = AnalysisSetContextRootsParams.fromRequest(request);
        final filteredRoots = params.roots
            .where((contextRoot) =>
                contextRoot.root == details.activeContext.activeRoot.root.path)
            .toList();
        if (filteredRoots.isNotEmpty) {
          final newRequest = AnalysisSetContextRootsParams(filteredRoots)
              .toRequest(request.id);
          _filteredRequest(newRequest, details);
        }
        break;
      case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
        final params = AnalysisSetPriorityFilesParams.fromRequest(request);
        final filteredFilePaths = params.files
            .where((filePath) =>
                details.activeContext.activeRoot.isAnalyzed(filePath))
            .toList();
        if (filteredFilePaths.isNotEmpty) {
          final newRequest = AnalysisSetPriorityFilesParams(filteredFilePaths)
              .toRequest(request.id);
          _filteredRequest(newRequest, details);
        }
        break;
      case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
        final params = AnalysisSetSubscriptionsParams.fromRequest(request);
        final filteredSubscriptions = params.subscriptions.map((key, value) {
          return MapEntry(
              key,
              value
                  .where((path) =>
                      details.activeContext.activeRoot.isAnalyzed(path))
                  .toList());
        });
        // if (filteredSubscriptions.isNotEmpty) {
        final newRequest = AnalysisSetSubscriptionsParams(filteredSubscriptions)
            .toRequest(request.id);
        _filteredRequest(newRequest, details);
        // }
        break;
      case ANALYSIS_REQUEST_UPDATE_CONTENT:
        final params = AnalysisUpdateContentParams.fromRequest(request);

        final newFiles = Map<String, Object>.from(params.files
          ..removeWhere((key, value) =>
              !details.activeContext.activeRoot.isAnalyzed(key)));
        final newRequest =
            AnalysisUpdateContentParams(newFiles).toRequest(request.id);
        _filteredRequest(newRequest, details);
        break;
      case COMPLETION_REQUEST_GET_SUGGESTIONS:
        final params = CompletionGetSuggestionsParams.fromRequest(request);
        _filteredRequest(request, details, path: params.file);
        break;
      case EDIT_REQUEST_GET_ASSISTS:
        final params = EditGetAssistsParams.fromRequest(request);
        _filteredRequest(request, details, path: params.file);
        break;
      case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
        final params = EditGetAvailableRefactoringsParams.fromRequest(request);
        _filteredRequest(request, details, path: params.file);
        break;
      case EDIT_REQUEST_GET_FIXES:
        final params = EditGetFixesParams.fromRequest(request);
        _filteredRequest(request, details, path: params.file);
        break;
      case EDIT_REQUEST_GET_REFACTORING:
        final params = EditGetRefactoringParams.fromRequest(request);
        _filteredRequest(request, details, path: params.file);
        break;
      case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
        final params = KytheGetKytheEntriesParams.fromRequest(request);
        _filteredRequest(request, details, path: params.file);
        break;
      case PLUGIN_REQUEST_SHUTDOWN:
        _filteredRequest(request, details);
        break;
      case PLUGIN_REQUEST_VERSION_CHECK:
        _filteredRequest(request, details);
        break;
      default:
        _filteredRequest(request, details);
        break;
    }
  }
}
