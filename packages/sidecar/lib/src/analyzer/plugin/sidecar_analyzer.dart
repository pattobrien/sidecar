// ignore_for_file: avoid_types_on_closure_parameters

import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart' hide LogRecord;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/models/context.dart';
import '../../protocol/requests/requests.dart';
import '../../protocol/responses/responses.dart';
import '../../protocol/source/source_edit.dart';
import '../../utils/duration_ext.dart';
import '../context/analyzed_file.dart';
import 'collection_provider.dart';
import 'files_provider.dart';
import 'resolved_unit_provider.dart';
import 'results_providers.dart';
import 'scoped_rules_provider.dart';
import 'plugin.dart';

final logger = Logger('sidecar-plugin');

class SidecarAnalyzer {
  SidecarAnalyzer(
    this._ref, {
    required RequestMessage initRequest,
  }) : context =
            Context(root: (initRequest.request as SetActiveRootRequest).root) {
    _initLogger();
    _setupListeners();
    _handleSetActiveRoot(initRequest);
  }

  final ProviderContainer _ref;
  final Context context;

  SidecarAnalyzerCommService get channel =>
      _ref.read(sidecarAnalyzerCommServiceProvider);

  Stream<dynamic> get stream => _ref.read(analyzerCommunicationStream.stream);

  OverlayResourceProvider get resourceProvider =>
      _ref.read(analyzerResourceProvider);

  void _initLogger() {
    logger.onRecord.listen((event) {
      final severity = LogSeverity.fromLogLevel(event.level);
      final record = LogRecord.fromAnalyzer(
          context, event.time, severity, event.message, event.stackTrace);
      final message = SidecarMessage.log(record);
      sendToRunner(message);
    });
  }

  void sendToRunner(SidecarMessage message) => channel.sendToRunner(message);

  void handleError(Object error, StackTrace stack) =>
      channel.sendToRunner(SidecarMessage.error(error, stack));

  void _setupListeners() {
    stream.listen(
      (dynamic event) {
        assert(event is String, 'incorrect type: ${event.runtimeType} $event');
        try {
          final json = jsonDecode(event as String) as Map<String, dynamic>;
          final message = RequestMessage.fromJson(json);
          handleRequest(message);
        } catch (e) {
          throw UnimplementedError('invalid message type: $e');
        }
      },
      onError: handleError,
    );
  }

  Future<void> handleRequest(RequestMessage msg) async {
    final response = await msg.request.map<FutureOr<SidecarResponse?>>(
      setActiveRoot: handleSetActiveRoot,
      setContextCollection: handleAnalysisSetContextRoots,
      setPriorityFiles: handleSetPriorityFiles,
      updateFiles: handleUpdateFiles,
      quickFix: handleEditGetFixes,
      assist: handleEditGetAssists,
      lint: handleLint,
    );

    if (response != null) {
      final responseMessage = SidecarMessage.response(response, id: msg.id);
      sendToRunner(responseMessage);
    }
  }

  SetPriorityFilesResponse handleSetPriorityFiles(
    SetPriorityFilesRequest request,
  ) {
    priorityFiles = request.files.toSet();
    return const SetPriorityFilesResponse();
  }

  Future<SetActiveRootResponse> handleSetActiveRoot(
    SetActiveRootRequest request,
  ) async {
    return const SetActiveRootResponse();
  }

  Future<void> _handleSetActiveRoot(RequestMessage request) async {
    final response =
        await handleSetActiveRoot(request.request as SetActiveRootRequest);
    sendToRunner(SidecarMessage.response(response, id: request.id));
  }

  Future<ContextCollectionResponse> handleAnalysisSetContextRoots(
    SetContextCollectionRequest request,
  ) async {
    logger.info('handleAnalysisSetContextRoots - mainRoot ${request.mainRoot}');
    logger.info('handleAnalysisSetContextRoots - allRoots: ${request.roots}');
    final notifier = _ref.read(contextCollectionProvider.notifier);
    notifier.setContextCollection(request.roots, []);
    await afterNewContextCollection();
    logger.info('handleAnalysisSetContextRoots complete');
    return const ContextCollectionResponse();
  }

  Future<LintResponse> handleLint(LintRequest request) {
    throw StateError('LintRequest is an invalid request');
  }

  /// This method is invoked when a new instance of [AnalysisContextCollection]
  /// is created, so the plugin can perform initial analysis of analyzed files.
  ///
  /// By default analyzes every [AnalysisContext] with [analyzeFiles].
  Future<void> afterNewContextCollection() async {
    logger.info('afterNewContextCollection');
    print('afterNewContextCollection');
    // await _forAnalysisContexts((analysisContext) async {
    final files = _ref.refresh(activeProjectScopedFilesProvider);
    print('afterNewContextCollection complte');
    // logger.info('afterNewContextCollection files: ${paths.toList()}');
    await analyzeFiles(files: files);
    // });
  }

  // Overridden to allow for non-Dart files to be analyzed for changes
  Future<void> contentChanged(Set<String> paths) async {
    // logger.info('contentChanged paths: ${paths.length} $paths');
    print('contentChanged paths: ${paths.length} $paths');
    final watch = Stopwatch()..start();

    await _forAnalysisContexts((analysisContext) async {
      // logger.info('root: ${analysisContext.contextRoot.root.path}');
      final contextPath = analysisContext.contextRoot.root.path;
      final localWatch = Stopwatch()..start();
      paths.forEach(analysisContext.changeFile);
      final affected = await analysisContext.applyPendingFileChanges();
      final affectedWithoutOriginalPaths = affected.toSet()..removeAll(paths);
      // sidecar custom implementation to analyze all non-dart files
      // TODO: does this incur performance issues?
      // final nonDartPathsInContext = paths
      //     .where((e) => analysisContext.contextRoot.isAnalyzed(e))
      //     .where((path) => p.extension(path) != '.dart');

      // for a better user experience:
      // first we handle the changed files, then we handle all affected files

      final files = _ref
          .read(activeProjectScopedFilesProvider)
          .where((e) => paths.any((path) => path == e.path))
          .where((element) =>
              element.context.contextRoot.root.path ==
              analysisContext.contextRoot.root.path)
          .toList();
      // print('changedFiles: $files');
      await handleAffectedFiles(
        analysisContext: analysisContext,
        files: files,
      );
      final affectedFiles = _ref
          .read(activeProjectScopedFilesProvider)
          .where(
              (e) => affectedWithoutOriginalPaths.any((path) => path == e.path))
          .where((element) =>
              element.context.contextRoot.root.path ==
              analysisContext.contextRoot.root.path)
          .toList();
      // print('affectedFiles: $affectedFiles');
      await handleAffectedFiles(
        analysisContext: analysisContext,
        // paths: [...affected, ...nonDartPathsInContext],
        files: affectedFiles,
      );
      print(
          'contentChanged $contextPath - ${localWatch.elapsed.prettified()} ${watch.elapsed.prettified()}');
    });
    print('contentChanged complete - ${watch.elapsed.prettified()}');
  }

  /// PATTOBRIEN:
  /// this is where we should handle the order of events that happen post-content change
  /// i.e.:
  /// - first, analyze high priority files
  /// - second, analyze low priority files
  /// - third, check for new annotations
  /// - fourth, proactively refresh assist filters
  /// - fifth, proactively calculate edits (assists and quick fixes)
  Future<void> handleAffectedFiles({
    required AnalysisContext analysisContext,
    required List<AnalyzedFileWithContext> files,
  }) async {
    logger.info('handleAffectedFiles paths: ${files.length} $files');
    for (final file in files) {
      _ref.refresh(nodeRegistryForFileProvider(file));
      // _ref.refresh(registryVisitorProvider(file));
      _ref.refresh(resolvedUnitForFileProvider(file));
      // _ref.refresh(unitContextProvider(file));
      // _ref.refresh(scopedVisitorForFileProvider(file));
      // _ref.refresh(lintResultsProvider(file));
    }
    // first analyze the files
    await analyzeFiles(files: files);
  }

  Future<void> _forAnalysisContexts(
    Future<void> Function(AnalysisContext analysisContext) f,
  ) async {
    final nonPriorityAnalysisContexts = <AnalysisContext>[];
    final analysisContexts = _ref.read(contextCollectionProvider);
    print('contexts: ${analysisContexts.length}');
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
    return priorityFiles
        .map((e) => e.path)
        .any(analysisContext.contextRoot.isAnalyzed);
  }

  Set<AnalyzedFile> priorityFiles = {};

  Future<void> analyzeFiles({
    required List<AnalyzedFileWithContext> files,
  }) async {
    logger.info('${DateTime.now()} starting analyzing files: $files');
    for (final file in files.where((file) => file.isDartFile)) {
      try {
        final watch = Stopwatch()..start();
        final results = await _ref.read(lintResultsProvider(file).future);
        print(
            'analyzeFiles ${file.relativePath} ${watch.elapsed.prettified()}');
        final notification =
            LintNotification(file.toAnalyzedFile(), results.toList());

        logger.info('results: ${file.relativePath} ${notification.toJson()}');
        channel.sendNotification(notification);
      } catch (e, stackTrace) {
        logger.severe('analyzeFiles:', e, stackTrace);
      }
    }
    logger.finest('${DateTime.now()}  finished analyzing files');
  }

  Future<QuickFixResponse> handleEditGetFixes(
    QuickFixRequest request,
  ) async {
    try {
      final contexts = _ref.read(contextCollectionProvider);
      final file = AnalyzedFileWithContext.fromFile(request.file, contexts);
      final fixes = await _ref.read(quickFixResultsProvider(file).future);
      return QuickFixResponse(fixes);
    } catch (e, stackTrace) {
      logger.severe('handleEditGetFixes ${request.file.path}', e, stackTrace);
      rethrow;
    }
  }

  Future<AssistResponse> handleEditGetAssists(
    AssistRequest request,
  ) async {
    final file = _ref
        .read(activeProjectScopedFilesProvider)
        .firstWhereOrNull((file) => file.path == request.file.path);

    if (file == null) return const AssistResponse([]);

    try {
      final results = await _ref.read(assistFiltersProvider(file).future);
      final resultsAtOffset = results
          .where((result) => result.isWithinOffset(file.path, request.offset));
      final resultsWithCalculations = await Future.wait(resultsAtOffset
          .map((e) async => _ref.read(assistResultsProvider(e).future)));
      return AssistResponse(resultsWithCalculations.expand((e) => e).toList());
    } catch (e, stack) {
      logger.severe('handleEditGetAssists ${file.relativePath}', e, stack);
      rethrow;
    }
  }

  int _overlayModificationStamp = 0;
  Future<UpdateFilesResponse> handleUpdateFiles(
    FileUpdateRequest request,
  ) async {
    print('handleUpdateFiles');
    final watch = Stopwatch()..start();
    final changedPaths = <String>{};

    for (final update in request.updates) {
      final filePath = update.filePath;
      final oldContents = resourceProvider.hasOverlay(filePath)
          ? resourceProvider.getFile(filePath).readAsStringSync()
          : null;

      update.map(
        add: (event) => resourceProvider.setOverlay(
          filePath,
          content: event.contents,
          modificationStamp: _overlayModificationStamp++,
        ),
        modify: (modify) {
          if (oldContents == null) {
            // The server should only send a ChangeContentOverlay if there is
            // already an existing overlay for the source.
            throw UnimplementedError('invalidOverlayChangeNoContent');
          }
          try {
            final contents = SourceEdit.applySequenceOfEdits(
                oldContents, modify.fileEdit.edits);
            resourceProvider.setOverlay(filePath,
                content: contents,
                modificationStamp: _overlayModificationStamp++);
            // ignore: avoid_catching_errors
          } on RangeError {
            throw UnimplementedError('invalidOverlayChangeInvalidEdit');
          }
        },
        delete: (_) => resourceProvider.removeOverlay(filePath),
      );

      changedPaths.add(filePath);
    }
    print('handleUpdateFiles - ${watch.elapsed.prettified()}');
    await contentChanged(changedPaths);
    print('handleUpdateFiles contentChanged - ${watch.elapsed.prettified()}');
    return const UpdateFilesResponse();
  }
}
