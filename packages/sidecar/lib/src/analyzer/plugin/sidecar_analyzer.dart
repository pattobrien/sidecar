// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:logging/logging.dart' as logging;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/requests/requests.dart';
import '../../protocol/responses/responses.dart';
import '../../protocol/source/source_edit.dart';
import '../context/active_context.dart';
import '../context/analyzed_file.dart';
import '../handlers/context_collection.dart';
import '../results/results.dart';
import 'plugin.dart';
import 'plugin_resource_provider.dart';

// part 'analyzer_plugin.g.dart';

final pluginLogger = logging.Logger('sidecar-plugin');

class SidecarAnalyzer {
  SidecarAnalyzer(
    this._ref, {
    required this.sendPort,
  }) : receivePort = ReceivePort('sidecar-analyzer');

  final initializationCompleter = Completer<void>();
  final ProviderContainer _ref;
  final SendPort sendPort;
  final ReceivePort receivePort;

  Stream get stream => receivePort.asBroadcastStream();

  AnalyzedFile getFileForPath(String path) =>
      _ref.read(analyzedFileForPathProvider(this, path));

  final List<String> roots = const [];

  OverlayResourceProvider get resourceProvider =>
      _ref.read(analyzerResourceProvider);

  void start() {
    pluginLogger.onRecord.listen((event) {
      final log = LogRecord(event.toString());
      final notification = SidecarMessage.log(log);
      final json = notification.toJson();
      final encodedJson = jsonEncode(json);
      sendPort.send(encodedJson);
    });
    pluginLogger.finer('END PLUGIN STARTING....');
    pluginLogger
        .finer('# of rules: ${_ref.read(ruleConstructorProvider).length}');
    _setupListeners();
    sendNotification(const InitCompleteNotification());
  }

  void _setupListeners() {
    sendPort.send(receivePort.sendPort);
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

  Future<ContextCollectionResponse> handleAnalysisSetContextRoots(
    SetContextCollectionRequest request,
  ) async {
    _collection = _ref.read(createContextCollectionProvider(request.roots));
    _ref.read(allContextsNotifierProvider.notifier).update(_collection);
    await afterNewContextCollection(contextCollection: _collection);
    return const ContextCollectionResponse();
  }

  /// This method is invoked when a new instance of [AnalysisContextCollection]
  /// is created, so the plugin can perform initial analysis of analyzed files.
  ///
  /// By default analyzes every [AnalysisContext] with [analyzeFiles].
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    await _forAnalysisContexts(contextCollection, (analysisContext) async {
      final paths = analysisContext.contextRoot.analyzedFiles().toList();
      await analyzeFiles(
        analysisContext: analysisContext,
        paths: paths,
      );
    });
  }

  Future<void> handleRequest(RequestMessage msg) async {
    final id = msg.id;
    final unparsedRequest = msg.request;
    final response = await unparsedRequest.mapOrNull<Future<SidecarResponse?>>(
      setContextCollection: handleAnalysisSetContextRoots,
      updateFiles: handleAnalysisUpdateContent,
      // quickFix: handleEditGetFixes,
      // assist: (request) => Future.value(),
      // fileUpdate: (request) => Future.value(),
    );

    if (response != null) {
      final wrappedResponse =
          SidecarMessage.response(response: response, id: id);
      final json = wrappedResponse.toJson();
      final encodedJson = jsonEncode(json);
      // print('response: $encodedJson');
      sendPort.send(encodedJson);
    }
  }

  void sendNotification(
    SidecarNotification notification,
  ) {
    final wrappedResponse =
        SidecarMessage.notification(notification: notification);
    final json = wrappedResponse.toJson();
    final encodedJson = jsonEncode(json);
    // print('sending notification: $encodedJson');
    sendPort.send(encodedJson);
  }

  // TODO: find a way to keep collection from being disposed of automatically
  late AnalysisContextCollection _collection;

  // Overridden to allow for non-Dart files to be analyzed for changes

  Future<void> contentChanged(List<String> paths) async {
    await _forAnalysisContexts(_collection, (analysisContext) async {
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
        analysisContext: analysisContext,
        paths: [...affected, ...nonDartPathsInContext],
        // paths: affected,
      );
    });
  }

  Future<void> handleAffectedFiles({
    required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {
    final analysisContexts = _ref.read(activeContextsProvider);
    for (final analysisContext in analysisContexts) {
      final analyzedPaths = paths
          .where(analysisContext.contextRoot.isAnalyzed)
          .toList(growable: false);

      await analyzeFiles(
        analysisContext: analysisContext.context,
        paths: analyzedPaths,
      );
    }
  }

  Future<void> _forAnalysisContexts(
    AnalysisContextCollection contextCollection,
    Future<void> Function(AnalysisContext analysisContext) f,
  ) async {
    final nonPriorityAnalysisContexts = <AnalysisContext>[];
    for (final analysisContext in contextCollection.contexts) {
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

  Set<String> priorityPaths = {};

  Future<void> analyzeFiles({
    required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {
    final activeContexts = _ref.read(activeContextsProvider);
    pluginLogger
        .finer('CHANGEDFILES = ${paths.length} ${paths.toList().toString()}');
    if (activeContexts.any((activeContext) =>
        activeContext.activeRoot.root.path ==
        analysisContext.contextRoot.root.path)) {
      // context is valid => analyze all files

      await Future.wait(paths.map((path) async {
        try {
          final file = _ref.read(analyzedFileForPathProvider(this, path));
          await _ref.read(getResolvedUnitForFileProvider(file).future);
          final results =
              await _ref.read(createAnalysisReportProvider(file).future);
          final notification = LintNotification(path, results);
          sendNotification(notification);
        } catch (e, stackTrace) {
          pluginLogger.severe('analyzeFiles', e, stackTrace);
        }
      }));
    }
  }

  // Future<QuickFixResponse> handleEditGetFixes(
  //   QuickFixRequest request,
  // ) async {
  //   try {
  //     //TODO: bug, edits are made for multiple files
  //     final fixes =
  //         await _ref.read(requestQuickFixesProvider(this, request).future);
  //     return QuickFixResponse(fixes);
  //   } catch (e, stackTrace) {
  //     pluginLogger.severe(
  //         'handleEditGetFixes ${request.filePath}', e, stackTrace);
  //     rethrow;
  //   }
  // }

  // Future<AssistResponse> handleEditGetAssists(
  //   AssistRequest request,
  // ) async {
  //   try {
  //     final path = request.filePath;
  //     final analyzedFile = _ref.read(analyzedFileForPathProvider(this, path));

  //     _ref.refresh(assistResultsForFileProvider(analyzedFile));
  //     _ref.refresh(assistResultsWithEditsProvider(analyzedFile));
  //     final results =
  //         await _ref.read(requestAssistResultsProvider(request).future);

  //     return QuickAssistResponse(results: results);
  //   } catch (e, stackTrace) {
  //     pluginLogger.severe(
  //         'handleEditGetAssists ${request.file.relativePath}', e, stackTrace);
  //     rethrow;
  //   }
  // }
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

  Future<plugin.CompletionGetSuggestionsResult> handleCompletionGetSuggestions(
    plugin.CompletionGetSuggestionsParams parameters,
  ) async {
    final filePath = parameters.file;
    final offset = parameters.offset;
    return plugin.CompletionGetSuggestionsResult(
      -1,
      -1,
      const <plugin.CompletionSuggestion>[],
    );
  }
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

