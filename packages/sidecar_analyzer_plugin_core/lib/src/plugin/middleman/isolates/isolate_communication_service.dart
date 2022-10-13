import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:riverpod/riverpod.dart';

import '../active_contexts/active_contexts.dart';

import 'isolate_details.dart';
import 'isolate_details_provider.dart';

final isolateCommunicationNotifierProvider =
    StateNotifierProvider<IsolateCommunicationService, List<IsolateDetails>>(
        (ref) {
  final activeContexts = ref.watch(activeContextRootsProvider);
  ref.listen(activeContextRootsProvider, (previous, next) {
    //
  });

  final isolates = activeContexts
      .map((context) => ref.watch(isolateDetailForContextProvider(context)));

  return IsolateCommunicationService(isolates.toList());
});

class IsolateCommunicationService extends StateNotifier<List<IsolateDetails>> {
  IsolateCommunicationService(List<IsolateDetails> isolateDetails)
      : super(isolateDetails);

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

  void _requestAllIsolates(Request request) {
    for (final isolate in state) {
      isolate.channel.sendRequest(request);
    }
  }

  void _requestBuilder<T>({
    required T Function(Request request) fromRequest,
    required void Function(IsolateDetails isolate) handler,
  }) {
    state.forEach(handler);
  }

  void _requestIndividualIsolate(
    Request request, {
    required String filePath,
  }) {
    final isolate =
        state.firstWhere((element) => element.contextRoot.isAnalyzed(filePath));
    isolate.channel.sendRequest(request);
  }

  // void _parseRequestType(
  //   Request request,
  //   int requestTime,
  //   ContextRoot root,
  // ) {
  //   switch (request.method) {
  //     case ANALYSIS_REQUEST_GET_NAVIGATION:
  //       final params = AnalysisGetNavigationParams.fromRequest(request);
  //       return _requestIndividualIsolate(request, filePath: params.file);
  //     case ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
  //       final params = AnalysisHandleWatchEventsParams.fromRequest(request);
  //       final filteredEvents = params.events
  //           .where((element) => root.isAnalyzed(element.path))
  //           .toList();
  //       final newRequest = AnalysisHandleWatchEventsParams(filteredEvents)
  //           .toRequest(request.id);
  //       // _filteredRequest(newRequest, root);
  //       throw UnimplementedError(
  //           'this is a function that could be giving errors; make sure this is implemented correctly!');
  //       break;
  //     case ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
  //       // final params = AnalysisSetContextRootsParams.fromRequest(request);
  //       // final filteredRoots = params.roots
  //       //     .where((contextRoot) => contextRoot.root == root.root.path)
  //       //     .toList();
  //       // if (filteredRoots.isNotEmpty) {
  //       //   final newRequest = AnalysisSetContextRootsParams(filteredRoots)
  //       //       .toRequest(request.id);
  //       //   _filteredRequest(newRequest, root);
  //       // }

  //       throw UnimplementedError('this case should be handled elsewhere');
  //       break;
  //     case ANALYSIS_REQUEST_SET_PRIORITY_FILES:
  //       // final params = AnalysisSetPriorityFilesParams.fromRequest(request);
  //       // final filteredFilePaths = params.files
  //       //     .where((filePath) => root.isAnalyzed(filePath))
  //       //     .toList();
  //       // if (filteredFilePaths.isNotEmpty) {
  //       //   final newRequest = AnalysisSetPriorityFilesParams(filteredFilePaths)
  //       //       .toRequest(request.id);
  //       //   _filteredRequest(newRequest, root);
  //       // }
  //       break;
  //     case ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
  //       final params = AnalysisSetSubscriptionsParams.fromRequest(request);
  //       final filteredSubscriptions = params.subscriptions.map((key, value) {
  //         return MapEntry(
  //             key, value.where((path) => root.isAnalyzed(path)).toList());
  //       });
  //       // if (filteredSubscriptions.isNotEmpty) {
  //       final newRequest = AnalysisSetSubscriptionsParams(filteredSubscriptions)
  //           .toRequest(request.id);
  //       _requestAllIsolates(newRequest);
  //       // }
  //       break;
  //     case ANALYSIS_REQUEST_UPDATE_CONTENT:
  //       final params = AnalysisUpdateContentParams.fromRequest(request);
  //       final newFiles = Map<String, Object>.from(
  //           params.files..removeWhere((key, value) => !root.isAnalyzed(key)));
  //       final newRequest =
  //           AnalysisUpdateContentParams(newFiles).toRequest(request.id);
  //       _requestAllIsolates(newRequest, root);
  //       break;
  //     case COMPLETION_REQUEST_GET_SUGGESTIONS:
  //       final params = CompletionGetSuggestionsParams.fromRequest(request);
  //       _filteredRequest(request, root, path: params.file);
  //       break;
  //     case EDIT_REQUEST_GET_ASSISTS:
  //       final params = EditGetAssistsParams.fromRequest(request);
  //       _filteredRequest(request, root, path: params.file);
  //       break;
  //     case EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
  //       final params = EditGetAvailableRefactoringsParams.fromRequest(request);
  //       _filteredRequest(request, root, path: params.file);
  //       break;
  //     case EDIT_REQUEST_GET_FIXES:
  //       final params = EditGetFixesParams.fromRequest(request);
  //       _filteredRequest(request, root, path: params.file);
  //       break;
  //     case EDIT_REQUEST_GET_REFACTORING:
  //       final params = EditGetRefactoringParams.fromRequest(request);
  //       _filteredRequest(request, root, path: params.file);
  //       break;
  //     case KYTHE_REQUEST_GET_KYTHE_ENTRIES:
  //       final params = KytheGetKytheEntriesParams.fromRequest(request);
  //       _filteredRequest(request, root, path: params.file);
  //       break;
  //     case PLUGIN_REQUEST_SHUTDOWN:
  //       _filteredRequest(request, root);
  //       break;
  //     case PLUGIN_REQUEST_VERSION_CHECK:
  //       _filteredRequest(request, root);
  //       break;
  //     default:
  //       _filteredRequest(request, root);
  //       break;
  //   }
  // }

  void addIsolate(IsolateDetails details) {
    // state = [...state, details];
    throw UnimplementedError();
  }

  void removeIsolate(IsolateDetails details) {
    throw UnimplementedError();
  }
}
