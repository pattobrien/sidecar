// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../protocol/requests/requests.dart';
import '../../protocol/responses/responses.dart';
import '../context/analyzed_file.dart';
import '../handlers/context_collection.dart';
import '../results/results.dart';
import 'plugin.dart';
import 'plugin_resource_provider.dart';

// part 'analyzer_plugin.g.dart';

final pluginLogger = Logger('sidecar-plugin');

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

  AnalysisContextCollection get _contextCollection =>
      _ref.read(contextCollectionProvider(roots));

  AnalyzedFile getFileForPath(String path) =>
      _ref.read(analyzedFileForPathProvider(this, path));

  final List<String> roots = const [];

  OverlayResourceProvider get resourceProvider =>
      _ref.read(analyzerResourceProvider);

  void start() {
    pluginLogger.onRecord.listen((event) => sendPort.send(event.toString()));
    pluginLogger.finer('END PLUGIN STARTING....');
    pluginLogger
        .finer('# of rules: ${_ref.read(ruleConstructorProvider).length}');
    _setupListeners();
    sendNotification(const InitCompleteNotification());
  }

  void _setupListeners() {
    sendPort.send(receivePort.sendPort);
    stream.listen((dynamic event) {
      print('event: $event');
      if (event is Map<String, dynamic>) {
        try {
          final message = SidecarMessage.fromJson(event);
          if (message is RequestMessage) {
            handleRequest(message);
            return;
          }
        } catch (e) {
          //
        }
      }
      throw UnimplementedError('unknown type received: ${event.runtimeType}');
    });
  }

  Future<ContextCollectionResponse> handleAnalysisSetContextRoots(
    SetContextCollectionRequest request,
  ) async {
    _collection = _ref.read(contextCollectionProvider(request.roots));
    return const ContextCollectionResponse();
  }

  Future<void> handleRequest(RequestMessage msg) async {
    final id = msg.id;
    final unparsedRequest = msg.request;
    final response = await unparsedRequest.map<Future<SidecarResponse?>>(
      setContextCollection: handleAnalysisSetContextRoots,
      analyzeFile: (request) => Future.value(),
      assist: (request) => Future.value(),
      quickFix: handleEditGetFixes,
      fileUpdate: (request) => Future.value(),
    );

    if (response != null) {
      final wrappedResponse =
          SidecarMessage.response(response: response, id: id);
      final json = wrappedResponse.toJson();
      print('response: $json');
      sendPort.send(json);
    }
  }

  void sendNotification(
    SidecarNotification notification,
  ) {
    final wrappedResponse =
        SidecarMessage.notification(notification: notification);
    final json = wrappedResponse.toJson();
    sendPort.send(json);
  }

  // TODO: find a way to keep collection from being disposed of automatically
  late AnalysisContextCollection _collection;

  // Overridden to allow for non-Dart files to be analyzed for changes

  Future<void> contentChanged(List<String> paths) async {
    await _forAnalysisContexts(_contextCollection, (analysisContext) async {
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
    final analyzedPaths = paths
        .where(analysisContext.contextRoot.isAnalyzed)
        .toList(growable: false);

    await analyzeFiles(
      analysisContext: analysisContext,
      paths: analyzedPaths,
    );
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
          await _ref.read(createAnalysisReportProvider(file).future);
        } catch (e, stackTrace) {
          pluginLogger.severe('analyzeFiles', e, stackTrace);
        }
      }));
    }
  }

  Future<QuickFixResponse> handleEditGetFixes(
    QuickFixRequest request,
  ) async {
    try {
      //TODO: bug, edits are made for multiple files
      final fixes =
          await _ref.read(requestQuickFixesProvider(this, request).future);
      return QuickFixResponse(fixes);
    } catch (e, stackTrace) {
      pluginLogger.severe(
          'handleEditGetFixes ${request.filePath}', e, stackTrace);
      rethrow;
    }
  }

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

