// // ignore_for_file: implementation_imports

// import 'dart:async';

// import 'package:analyzer/dart/analysis/analysis_context.dart';
// import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
// import 'package:analyzer/file_system/overlay_file_system.dart';
// import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
// import 'package:analyzer/src/dart/analysis/byte_store.dart';

// import 'package:analyzer_plugin/channel/channel.dart' as plugin;
// import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
// import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
// import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
// import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
// import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
// import 'package:analyzer_plugin/src/protocol/protocol_internal.dart' as plugin;

// import 'package:logging/logging.dart';
// import 'package:path/path.dart' as p;
// import 'package:riverpod/riverpod.dart';

// import '../../protocol/constants/constants.dart';
// import '../../protocol/protocol.dart';
// import '../../utils/byte_store_ext.dart';
// // import '../../utils/logger/logger.dart';
// import '../../utils/channel_extension.dart';
// import '../../utils/logger/debugger_delegate.dart';
// import '../options_provider.dart';
// import '../results/results.dart';
// import '../server/analyzer_mode.dart';
// import '../server/log_delegate.dart';
// import 'plugin.dart';

// final pluginLogger = Logger('sidecar-plugin');

// class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
//   SidecarAnalyzerPlugin(this.ref)
//       : resourceProvider = ref.read(pluginResourceProvider),
//         super(resourceProvider: ref.read(pluginResourceProvider));

//   final initializationCompleter = Completer<void>();
//   final Ref ref;

//   @override
//   String get name => kSidecarPluginName;

//   @override
//   String get version => kPluginVersion;

//   @override
//   List<String> get fileGlobsToAnalyze => kPluginGlobs;

//   SidecarAnalyzerMode get mode => ref.read(cliOptionsProvider).mode;

//   AnalysisContextCollection? _contextCollection;
//   late final ByteStore _byteStore =
//       resourceProvider.createByteStore(kSidecarPluginName);

//   @override
//   // ignore: overridden_fields
//   final OverlayResourceProvider resourceProvider;

//   @override
//   void start(plugin.PluginCommunicationChannel channel) {
//     pluginLogger.onRecord
//         .listen((event) => channel.sendError(event.toString()));
//     pluginLogger.finer('END PLUGIN STARTING....');
//     pluginLogger
//         .finer('# of rules: ${ref.read(ruleConstructorProvider).length}');
//     if (mode.isDebug) {
//       // pluginLogger.finer('STARTING WITH HOT RELOAD');
//     }

//     channel.listen(_onRequest, onError: onError, onDone: onDone);
//     channel.sendNotification(
//       plugin.Notification(kInitializationCompleteMethod, {}),
//     );
//   }

//   @override
//   Future<plugin.AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(
//     plugin.AnalysisSetContextRootsParams parameters,
//   ) async {
//     if (mode.isCli || mode.isDebug) {
//       // create our own set context handler
//       final includedPaths = parameters.roots.map((e) => e.root).toList();

//       final contextCollection = runZonedGuarded(
//         () => AnalysisContextCollectionImpl(
//           includedPaths: includedPaths,
//           byteStore: _byteStore,
//           // resourceProvider:  PhysicalResourceProvider.INSTANCE,
//           // sdkPath: sdkPath,
//           // fileContentCache: FileContentCache(resourceProvider),
//         ),
//         (e, s) {},
//         zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
//       );

//       _contextCollection = contextCollection;
//       await afterNewContextCollection(contextCollection: contextCollection!);
//       return plugin.AnalysisSetContextRootsResult();
//     } else {
//       return super.handleAnalysisSetContextRoots(parameters);
//     }
//   }

//   /// Handle an 'analysis.setContextRoots' request.
//   ///
//   /// Throw a [RequestFailure] if the request could not be handled.
//   Future<AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(
//       AnalysisSetContextRootsParams parameters) async {
//     final currentContextCollection = _contextCollection;
//     if (currentContextCollection != null) {
//       _contextCollection = null;
//       await beforeContextCollectionDispose(
//         contextCollection: currentContextCollection,
//       );
//       await currentContextCollection.dispose();
//     }

//     final includedPaths = parameters.roots.map((e) => e.root).toList();
//     final contextCollection = AnalysisContextCollectionImpl(
//       resourceProvider: resourceProvider,
//       includedPaths: includedPaths,
//       byteStore: _byteStore,
//       sdkPath: _sdkPath,
//       fileContentCache: FileContentCache(resourceProvider),
//     );
//     _contextCollection = contextCollection;
//     await afterNewContextCollection(
//       contextCollection: contextCollection,
//     );
//     return AnalysisSetContextRootsResult();
//   }

//   @override
//   Future<void> afterNewContextCollection({
//     required AnalysisContextCollection contextCollection,
//   }) async {
//     _contextCollection = contextCollection;
//     pluginLogger.finer('ISOLATE: afterNewContextCollection');

//     ref
//         .read(allAnalysisContextsNotifierProvider.notifier)
//         .update(contextCollection);

//     await super.afterNewContextCollection(contextCollection: contextCollection);
//     if (mode.isCli) initializationCompleter.complete();
//   }
//   /// This method is invoked when a new instance of [AnalysisContextCollection]
//   /// is created, so the plugin can perform initial analysis of analyzed files.
//   ///
//   /// By default analyzes every [AnalysisContext] with [analyzeFiles].
//   Future<void> afterNewContextCollection({
//     required AnalysisContextCollection contextCollection,
//   }) async {
//     await _forAnalysisContexts(contextCollection, (analysisContext) async {
//       final paths = analysisContext.contextRoot.analyzedFiles().toList();
//       await analyzeFiles(
//         analysisContext: analysisContext,
//         paths: paths,
//       );
//     });
//   }

//   // Overridden to allow for non-Dart files to be analyzed for changes
//   @override
//   Future<void> contentChanged(List<String> paths) async {
//     final contextCollection = _contextCollection;
//     if (contextCollection != null) {
//       await _forAnalysisContexts(contextCollection, (analysisContext) async {
//         // ignore: prefer_foreach
//         for (final path in paths) {
//           analysisContext.changeFile(path);
//         }
//         final affected = await analysisContext.applyPendingFileChanges();

//         // sidecar custom implementation to analyze all non-dart files
//         final nonDartPathsInContext = paths
//             .where((e) => analysisContext.contextRoot.isAnalyzed(e))
//             .where((path) => p.extension(path) != '.dart');

//         await handleAffectedFiles(
//           analysisContext: analysisContext,
//           paths: [...affected, ...nonDartPathsInContext],
//           // paths: affected,
//         );
//       });
//     }
//   }

//   /// Handles files that might have been affected by a content change of
//   /// one or more files. The implementation may check if these files should
//   /// be analyzed, do such analysis, and send diagnostics.
//   ///
//   /// By default invokes [analyzeFiles] only for files that are analyzed in
//   /// this [analysisContext].
//   @override
//   Future<void> handleAffectedFiles({
//     required AnalysisContext analysisContext,
//     required List<String> paths,
//   }) async {
//     final analyzedPaths = paths
//         .where(analysisContext.contextRoot.isAnalyzed)
//         .toList(growable: false);

//     await analyzeFiles(
//       analysisContext: analysisContext,
//       paths: analyzedPaths,
//     );
//   }

//   Future<void> _forAnalysisContexts(
//     AnalysisContextCollection contextCollection,
//     Future<void> Function(AnalysisContext analysisContext) f,
//   ) async {
//     final nonPriorityAnalysisContexts = <AnalysisContext>[];
//     for (final analysisContext in contextCollection.contexts) {
//       if (_isPriorityAnalysisContext(analysisContext)) {
//         await f(analysisContext);
//       } else {
//         nonPriorityAnalysisContexts.add(analysisContext);
//       }
//     }

//     for (final analysisContext in nonPriorityAnalysisContexts) {
//       await f(analysisContext);
//     }
//   }

//   bool _isPriorityAnalysisContext(AnalysisContext analysisContext) {
//     return priorityPaths.any(analysisContext.contextRoot.isAnalyzed);
//   }

//   @override
//   Future<void> analyzeFiles({
//     required AnalysisContext analysisContext,
//     required List<String> paths,
//   }) async {
//     final activeContexts = ref.read(activeContextsProvider);
//     pluginLogger
//         .finer('CHANGEDFILES = ${paths.length} ${paths.toList().toString()}');
//     if (activeContexts.any((activeContext) =>
//         activeContext.activeRoot.root.path ==
//         analysisContext.contextRoot.root.path)) {
//       // context is valid => analyze all files

//       await Future.wait(paths.map((path) async {
//         try {
//           final file = ref.read(analyzedFileForPathProvider(this, path));
//           await ref.read(getResolvedUnitForFileProvider(file).future);
//           // ref.read(analysisResultsForFileProvider(file));
//           // ref.invalidate(analysisResultsReporterProvider(file));
//           await ref.read(createAnalysisReportProvider(file).future);
//         } catch (e, stackTrace) {
//           pluginLogger.severe('analyzeFiles', e, stackTrace);
//         }
//       }));
//     }
//   }

//   @override
//   Future<void> analyzeFile({
//     required AnalysisContext analysisContext,
//     required String path,
//   }) async {}

//   @override
//   Future<plugin.EditGetFixesResult> handleEditGetFixes(
//     plugin.EditGetFixesParams parameters,
//   ) async {
//     final path = parameters.file;
//     final offset = parameters.offset;
//     try {
//       final analyzedFile = ref.read(analyzedFileForPathProvider(this, path));
//       final editRequest = QuickFixRequest(offset: offset, file: analyzedFile);
//       //TODO: bug, edits are made for multiple files
//       final fixes =
//           await ref.read(requestQuickFixesProvider(this, editRequest).future);

//       return plugin.EditGetFixesResult(fixes);
//     } catch (e, stackTrace) {
//       pluginLogger.severe('handleEditGetFixes $path', e, stackTrace);
//       rethrow;
//     }
//   }

//   @override
//   Future<plugin.EditGetAssistsResult> handleEditGetAssists(
//     plugin.EditGetAssistsParams parameters,
//   ) async {
//     try {
//       final analyzedFile =
//           ref.read(analyzedFileForPathProvider(this, parameters.file));
//       final quickAssistRequest = QuickAssistRequest(
//         file: analyzedFile,
//         offset: parameters.offset,
//         length: parameters.length,
//       );

//       ref.refresh(assistResultsForFileProvider(analyzedFile));
//       ref.refresh(assistResultsWithEditsProvider(analyzedFile));
//       final results = await ref
//           .read(requestAssistResultsProvider(quickAssistRequest).future);

//       final changes = results
//           .map((e) => e.toPrioritizedSourceChanges())
//           .expand((e) => e)
//           .toList();

//       return plugin.EditGetAssistsResult(changes);
//     } catch (e, stackTrace) {
//       pluginLogger.severe(
//           'handleEditGetAssists ${parameters.file}', e, stackTrace);
//       rethrow;
//     }
//   }

//   /// Handle a 'completion.getSuggestions' request.
//   ///
//   /// Throw a [plugin.RequestFailure] if the request could not be handled.
//   @override
//   Future<plugin.CompletionGetSuggestionsResult> handleCompletionGetSuggestions(
//     plugin.CompletionGetSuggestionsParams parameters,
//   ) async {
//     final filePath = parameters.file;
//     final offset = parameters.offset;
//     return plugin.CompletionGetSuggestionsResult(
//       -1,
//       -1,
//       const <plugin.CompletionSuggestion>[],
//     );
//   }

//   /// Compute the response that should be returned for the given [request], or
//   /// `null` if the response has already been sent.
//   Future<plugin.Response?> _getResponse(
//       plugin.Request request, int requestTime) async {
//     plugin.ResponseResult? result;
//     switch (request.method) {
//       case plugin.ANALYSIS_REQUEST_GET_NAVIGATION:
//         var params = plugin.AnalysisGetNavigationParams.fromRequest(request);
//         result = await handleAnalysisGetNavigation(params);
//         break;
//       case plugin.ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
//         var params =
//             plugin.AnalysisHandleWatchEventsParams.fromRequest(request);
//         result = await handleAnalysisHandleWatchEvents(params);
//         break;
//       case plugin.ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
//         var params = plugin.AnalysisSetContextRootsParams.fromRequest(request);
//         result = await handleAnalysisSetContextRoots(params);
//         break;
//       case plugin.ANALYSIS_REQUEST_SET_PRIORITY_FILES:
//         var params = plugin.AnalysisSetPriorityFilesParams.fromRequest(request);
//         result = await handleAnalysisSetPriorityFiles(params);
//         break;
//       case plugin.ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
//         var params = plugin.AnalysisSetSubscriptionsParams.fromRequest(request);
//         result = await handleAnalysisSetSubscriptions(params);
//         break;
//       case plugin.ANALYSIS_REQUEST_UPDATE_CONTENT:
//         var params = plugin.AnalysisUpdateContentParams.fromRequest(request);
//         result = await handleAnalysisUpdateContent(params);
//         break;
//       case plugin.COMPLETION_REQUEST_GET_SUGGESTIONS:
//         var params = plugin.CompletionGetSuggestionsParams.fromRequest(request);
//         result = await handleCompletionGetSuggestions(params);
//         break;
//       case plugin.EDIT_REQUEST_GET_ASSISTS:
//         var params = plugin.EditGetAssistsParams.fromRequest(request);
//         result = await handleEditGetAssists(params);
//         break;
//       case plugin.EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
//         var params =
//             plugin.EditGetAvailableRefactoringsParams.fromRequest(request);
//         result = await handleEditGetAvailableRefactorings(params);
//         break;
//       case plugin.EDIT_REQUEST_GET_FIXES:
//         var params = plugin.EditGetFixesParams.fromRequest(request);
//         result = await handleEditGetFixes(params);
//         break;
//       case plugin.EDIT_REQUEST_GET_REFACTORING:
//         var params = plugin.EditGetRefactoringParams.fromRequest(request);
//         result = await handleEditGetRefactoring(params);
//         break;
//       case plugin.KYTHE_REQUEST_GET_KYTHE_ENTRIES:
//         var params = plugin.KytheGetKytheEntriesParams.fromRequest(request);
//         result = await handleKytheGetKytheEntries(params);
//         break;
//       case plugin.PLUGIN_REQUEST_SHUTDOWN:
//         var params = plugin.PluginShutdownParams();
//         result = await handlePluginShutdown(params);
//         channel.sendResponse(result.toResponse(request.id, requestTime));
//         channel.close();
//         return null;
//       case plugin.PLUGIN_REQUEST_VERSION_CHECK:
//         var params = plugin.PluginVersionCheckParams.fromRequest(request);
//         result = await handlePluginVersionCheck(params);
//         break;
//     }
//     if (result == null) {
//       return plugin.Response(request.id, requestTime,
//           error: plugin.RequestErrorFactory.unknownRequest(request.method));
//     }
//     return result.toResponse(request.id, requestTime);
//   }

//   /// The method that is called when a [request] is received from the analysis
//   /// server.
//   Future<void> _onRequest(plugin.Request request) async {
//     var requestTime = DateTime.now().millisecondsSinceEpoch;
//     var id = request.id;
//     plugin.Response? response;
//     try {
//       response = await _getResponse(request, requestTime);
//     } on plugin.RequestFailure catch (exception) {
//       response = plugin.Response(id, requestTime, error: exception.error);
//     } catch (exception, stackTrace) {
//       response = plugin.Response(id, requestTime,
//           error: plugin.RequestError(
//               plugin.RequestErrorCode.PLUGIN_ERROR, exception.toString(),
//               stackTrace: stackTrace.toString()));
//     }
//     if (response != null) {
//       channel.sendResponse(response);
//     }
//   }

//   /// Send a notification for the file at the given [path] corresponding to the
//   /// given [service].
//   void _sendNotificationForFile(String path, plugin.AnalysisService service) {
//     switch (service) {
//       case plugin.AnalysisService.FOLDING:
//         sendFoldingNotification(path);
//         break;
//       case plugin.AnalysisService.HIGHLIGHTS:
//         sendHighlightsNotification(path);
//         break;
//       case plugin.AnalysisService.NAVIGATION:
//         sendNavigationNotification(path);
//         break;
//       case plugin.AnalysisService.OCCURRENCES:
//         sendOccurrencesNotification(path);
//         break;
//       case plugin.AnalysisService.OUTLINE:
//         sendOutlineNotification(path);
//         break;
//     }
//   }
// }

// final pluginInitializationProvider = FutureProvider.autoDispose<void>(
//   (ref) async {
//     final plugin = ref.watch(pluginProvider);
//     await plugin.initializationCompleter.future;
//     final loggerDelegate = ref.watch(logDelegateProvider);
//     final cliOptions = ref.watch(cliOptionsProvider);
//     if (cliOptions.mode.isCli) {
//       loggerDelegate as DebuggerLogDelegate;
//       loggerDelegate.dumpResults();
//     }
//   },
//   name: 'pluginInitializationProvider',
//   dependencies: [
//     pluginProvider,
//     logDelegateProvider,
//     cliOptionsProvider,
//   ],
// );

// final pluginProvider = Provider.autoDispose<SidecarAnalyzerPlugin>(
//   SidecarAnalyzerPlugin.new,
//   name: 'pluginProvider',
//   dependencies: [
//     activeContextsProvider,
//     quickFixForRequestProvider,
//     analyzedFileFromPath,
//     allAnalysisContextsNotifierProvider,
//     logDelegateProvider,
//     ruleConstructorProvider,
//     cliOptionsProvider,
//     pluginResourceProvider,
//   ],
// );
