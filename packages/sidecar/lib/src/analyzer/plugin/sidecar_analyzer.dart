import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:logging/logging.dart' hide LogRecord;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/models/context.dart';
import '../../protocol/requests/requests.dart';
import '../../protocol/responses/responses.dart';
import '../../protocol/source/source_edit.dart';
import '../context/analyzed_file.dart';
import '../handlers/context_collection.dart';
import '../results/results.dart';
import 'analyzer_resource_provider.dart';
import 'plugin.dart';
import 'sidecar_analyzer_comm_service.dart';

final logger = Logger('sidecar-plugin');

class SidecarAnalyzer {
  SidecarAnalyzer(
    this._ref, {
    required this.sP,
    // required this.context,
    required RequestMessage initRequest,
    // required this.rootUri,
  }) : context =
            Context(root: (initRequest.request as SetActiveRootRequest).root) {
    _initLogger();
    handleSetActiveRoot(initRequest);
    _setupListeners();
  }

  // final initializationCompleter = Completer<void>();
  final ProviderContainer _ref;
  final SendPort sP;
  final Context context;
  // final Uri rootUri;

  SidecarAnalyzerCommService get communication =>
      _ref.read(sidecarAnalyzerCommServiceProvider(sP));

  Stream<dynamic> get stream =>
      _ref.read(analyzerCommunicationStream(sP).stream);

  AnalyzedFile getFileForPath(String path) =>
      _ref.read(analyzedFileForPathProvider(path));

  OverlayResourceProvider get resourceProvider =>
      _ref.read(analyzerResourceProvider);

  // void start() {
  //   // logger.onRecord.listen((event) {});
  //   // logger.finer('END PLUGIN STARTING....');
  //   // logger.finer('# of rules: ${_ref.read(ruleConstructorProvider).length}');

  //   // sendNotification(const InitCompleteNotification());
  // }

  void _initLogger() {
    logger.onRecord.listen((event) {
      final severity = LogSeverity.fromLogLevel(event.level);
      final record =
          LogRecord.fromAnalyzer(context, event.time, severity, event.message);
      final message = SidecarMessage.log(record);
      sendToRunner(message);
    });
  }

  void sendToRunner(SidecarMessage message) =>
      communication.sendToRunner(message);

  void _setupListeners() {
    // _sendPort.send(receivePort.sendPort);
    stream.listen((dynamic event) {
      // print('event: $event');
      if (event is String) {
        try {
          final json = jsonDecode(event) as Map<String, dynamic>;
          final message = SidecarMessage.fromJson(json);
          if (message is RequestMessage) {
            handleRequest(message);
            return;
          }
        } catch (e) {
          throw UnimplementedError('invalid message type: ${e.runtimeType} $e');
        }
      }
      if (event is Map<String, dynamic>) {
        throw UnimplementedError('invalid message map : $event');
        // try {
        //   final message = SidecarMessage.fromJson(event);
        //   if (message is RequestMessage) {
        //     handleRequest(message);
        //     return;
        //   }
        // } catch (e) {
        //   //
        // }
      }
      throw UnimplementedError('unknown type received: ${event.runtimeType}');
    });
  }

  Future<void> handleSetActiveRoot(
    RequestMessage request,
  ) async {
    //TODO; send the Context instance in the request, instead of just the Uri itself
    // context = Context(root: request.root);
    // _initLogger();
    // logger.severe('handleSetActiveRoot: ${context.root}');
    _ref.read(activeContextNotifierProvider.notifier).updateRoot(context.root);
    // print('active context root set to: ${activeContextRoot.path}');
    // return const SetActiveRootResponse();
    const response = SetActiveRootResponse();
    final wrappedResponse =
        SidecarMessage.response(response: response, id: request.id);
    communication.sendToRunner(wrappedResponse);
  }

  Future<ContextCollectionResponse> handleAnalysisSetContextRoots(
    SetContextCollectionRequest request,
  ) async {
    logger.info('handleAnalysisSetContextRoots');
    final collection =
        _ref.read(createContextCollectionProvider(request.roots));
    _ref.read(allContextsNotifierProvider.notifier).update(collection);
    // roots = request.roots;
    await afterNewContextCollection();
    logger.info('handleAnalysisSetContextRoots complete');
    return const ContextCollectionResponse();
  }

  /// This method is invoked when a new instance of [AnalysisContextCollection]
  /// is created, so the plugin can perform initial analysis of analyzed files.
  ///
  /// By default analyzes every [AnalysisContext] with [analyzeFiles].
  Future<void> afterNewContextCollection() async {
    logger.severe('afterNewContextCollection');
    await _forAnalysisContexts((analysisContext) async {
      final paths = analysisContext.contextRoot.analyzedFiles().toList();
      final files =
          paths.map((e) => _ref.read(analyzedFileForPathProvider(e))).toList();
      logger.info('afterNewContextCollection files: ${paths.toList()}');
      await analyzeFiles(
        // analysisContext: analysisContext,
        files: files,
      );
    });
  }

  Future<void> handleRequest(RequestMessage msg) async {
    final id = msg.id;
    final unparsedRequest = msg.request;
    final response = await unparsedRequest.map<Future<SidecarResponse?>>(
      setActiveRoot: (_) =>
          throw StateError('setActiveRoot should happen before initialization'),
      setContextCollection: handleAnalysisSetContextRoots,
      updateFiles: handleAnalysisUpdateContent,
      quickFix: handleEditGetFixes,
      assist: handleEditGetAssists,
      lint: (value) => throw StateError('lint is an invalid request'),
    );

    if (response != null) {
      final wrappedResponse =
          SidecarMessage.response(response: response, id: id);
      // final json = wrappedResponse.toJson();
      // final encodedJson = jsonEncode(json);
      // print('response: $encodedJson');
      // sendPort.send(encodedJson);
      sendToRunner(wrappedResponse);
    }
  }

  // TODO: find a way to keep collection from being disposed of automatically
  // late AnalysisContextCollection _collection;

  // Overridden to allow for non-Dart files to be analyzed for changes

  Future<void> contentChanged(List<String> paths) async {
    await _forAnalysisContexts((analysisContext) async {
      // logger.info('root: ${analysisContext.contextRoot.root.path}');
      // ignore: prefer_foreach
      for (final path in paths) {
        analysisContext.changeFile(path);
      }
      final affected = await analysisContext.applyPendingFileChanges();

      // sidecar custom implementation to analyze all non-dart files
      final nonDartPathsInContext = paths
          .where((e) => analysisContext.contextRoot.isAnalyzed(e))
          .where((path) => p.extension(path) != '.dart');

      await handleAffectedFiles(
        // analysisContext: analysisContext,
        paths: [...affected, ...nonDartPathsInContext],
        // paths: affected,
      );
    });
  }

  Future<void> handleAffectedFiles({
    // required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {
    final analysisContexts = _ref.read(allContextsNotifierProvider);
    for (final analysisContext in analysisContexts) {
      final files = paths
          .map((e) => _ref.read(analyzedFileForPathProvider(e)))
          .where((element) =>
              element.context.root == analysisContext.contextRoot.root.toUri())
          .toList();

      await analyzeFiles(files: files);
    }
  }

  Future<void> _forAnalysisContexts(
    Future<void> Function(AnalysisContext analysisContext) f,
  ) async {
    final nonPriorityAnalysisContexts = <AnalysisContext>[];
    final analysisContexts = _ref.read(allContextsNotifierProvider);
    for (final analysisContext in analysisContexts) {
      if (_isPriorityAnalysisContext(analysisContext)) {
        await f(analysisContext);
      } else {
        nonPriorityAnalysisContexts.add(analysisContext);
      }
    }

    for (final analysisContext in nonPriorityAnalysisContexts) {
      await f(analysisContext);
    }
  }

  bool _isPriorityAnalysisContext(AnalysisContext analysisContext) {
    return priorityPaths.any(analysisContext.contextRoot.isAnalyzed);
  }

  //TODO utilize priority paths
  static Set<String> priorityPaths = {};

  Future<void> analyzeFiles({
    // required AnalysisContext analysisContext,
    required List<AnalyzedFile> files,
  }) async {
    logger.finest('${DateTime.now()} starting analyzing files: $files');
    await Future.wait(files.map((file) async {
      try {
        await _ref.read(getResolvedUnitForFileProvider(file).future);
        final results =
            await _ref.read(createAnalysisReportProvider(file).future);
        final notification = LintNotification(file, results);
        communication.sendNotification(notification);
      } catch (e, stackTrace) {
        logger.severe('analyzeFiles', e, stackTrace);
      }
    }));
    logger.finest('${DateTime.now()}  finished analyzing files');
    // }
  }

  Future<QuickFixResponse> handleEditGetFixes(
    QuickFixRequest request,
  ) async {
    try {
      //TODO: bug, edits are made for multiple files
      final fixes = await _ref.read(requestQuickFixesProvider(request).future);
      return QuickFixResponse(fixes);
    } catch (e, stackTrace) {
      logger.severe('handleEditGetFixes ${request.file.path}', e, stackTrace);
      rethrow;
    }
  }

  Future<AssistResponse> handleEditGetAssists(
    AssistRequest request,
  ) async {
    try {
      final path = request.file.path;
      final analyzedFile = _ref.read(analyzedFileForPathProvider(path));

      _ref.refresh(assistResultsForFileProvider(analyzedFile));
      _ref.refresh(assistResultsWithEditsProvider(analyzedFile));
      final results =
          await _ref.read(requestAssistResultsProvider(request).future);

      return AssistResponse(results);
    } catch (e, stackTrace) {
      logger.severe(
          'handleEditGetAssists ${request.file.relativePath}', e, stackTrace);
      rethrow;
    }
  }

  int _overlayModificationStamp = 0;
  Future<UpdateFilesResponse> handleAnalysisUpdateContent(
    FileUpdateRequest request,
  ) async {
    final changedPaths = <String>{};
    final updates = request.updates;
    for (final update in updates) {
      // Prepare the old overlay contents.
      final filePath = update.filePath;
      String? oldContents;
      try {
        if (resourceProvider.hasOverlay(filePath)) {
          final file = resourceProvider.getFile(filePath);
          oldContents = file.readAsStringSync();
        }
      } catch (_) {}
      update.map(
        add: (event) {
          resourceProvider.setOverlay(
            filePath,
            content: event.contents,
            modificationStamp: _overlayModificationStamp++,
          );
          logger.info('add: $filePath updated');
        },
        modify: (modify) {
          if (oldContents == null) {
            // The server should only send a ChangeContentOverlay if there is
            // already an existing overlay for the source.
            throw UnimplementedError('invalidOverlayChangeNoContent');
          }
          try {
            final newContents = SourceEdit.applySequenceOfEdits(
                oldContents, modify.fileEdit.edits);
            resourceProvider.setOverlay(
              filePath,
              content: newContents,
              modificationStamp: _overlayModificationStamp++,
            );
          } on RangeError {
            throw UnimplementedError('invalidOverlayChangeInvalidEdit');
          }
        },
        delete: (delete) {
          resourceProvider.removeOverlay(filePath);
        },
      );

      changedPaths.add(filePath);
    }
    await contentChanged(changedPaths.toList());
    return const UpdateFilesResponse();
  }

  // Future<plugin.CompletionGetSuggestionsResult> handleCompletionGetSuggestions(
  //   plugin.CompletionGetSuggestionsParams parameters,
  // ) async {
  //   final filePath = parameters.file;
  //   final offset = parameters.offset;
  //   return plugin.CompletionGetSuggestionsResult(
  //     -1,
  //     -1,
  //     const <plugin.CompletionSuggestion>[],
  //   );
  // }
}

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
//     createPluginProvider,
//     logDelegateProvider,
//     cliOptionsProvider,
//   ],
// );
