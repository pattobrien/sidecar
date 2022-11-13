// ignore_for_file: avoid_types_on_closure_parameters

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart' hide LogRecord;
import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/models/context.dart';
import '../../protocol/models/models.dart';
import '../../protocol/requests/requests.dart';
import '../../protocol/responses/responses.dart';
import '../../protocol/source/source_edit.dart';
import '../../rules/typedefs.dart';
import '../../utils/duration_ext.dart';
import '../context/active_package.dart';
import '../context/analyzed_file.dart';
import 'active_package_provider.dart';
import 'collection_provider.dart';
import 'files_provider.dart';
import 'plugin.dart';
import 'resolved_unit_provider.dart';
import 'results_providers.dart';

final logger = Logger('sidecar-plugin');

final sidecarAnalyzerProvider = Provider((ref) {
  return SidecarAnalyzer(ref);
});

class SidecarAnalyzer {
  SidecarAnalyzer(
    this._ref,
  ) {
    _initLogger();
    _init();
  }

  final Ref _ref;

  SidecarAnalyzerCommService get channel =>
      _ref.read(sidecarAnalyzerCommServiceProvider);

  Stream<dynamic> get stream => _ref.read(analyzerCommunicationStream.stream);

  OverlayResourceProvider get resourceProvider =>
      _ref.read(analyzerResourceProvider);
  void _init() async {
    _setupListeners();
    // final notifier = _ref.read(contextCollectionProvider.notifier);
    // final workspaceScope = _ref.read(provider);
    // final activePackage = _ref.read(activePackageProvider).value!;
    // if (request.workspaceScope != null) {
    //   final contextRoots = request.workspaceScope!.map((e) => e.path).toList();
    //   notifier.setContextCollection(contextRoots, []);
    // } else {
    // final roots = request.package.dependencies.map((e) => e.path).toList();
    // final roots = [activePackage.root.path];
    // notifier.setContextCollection(roots, []);
    // }
    await afterNewContextCollection();
  }

  void _initLogger() {
    logger.onRecord.listen((event) {
      final severity = LogSeverity.fromLogLevel(event.level);
      final package = _ref.read(activePackageProvider).value!;
      final record = LogRecord.fromAnalyzer(
          package, event.time, severity, event.message, event.stackTrace);
      final message = SidecarMessage.log(record);
      sendToRunner(message);
    });
  }

  void sendToRunner(SidecarMessage message) => channel.sendToRunner(message);

  void handleError(Object error, StackTrace stack) =>
      channel.sendToRunner(SidecarMessage.error(error, stack));
  final isSetupCompleter = Completer<void>();

  void _setupListeners() {
    if (isSetupCompleter.isCompleted) return;
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
    isSetupCompleter.complete();
  }

  Future<void> handleRequest(RequestMessage msg) async {
    final response = await msg.request.map<FutureOr<SidecarResponse?>>(
      setActivePackage: handleSetActivePackage,
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

  Future<SetActivePackageResponse> handleSetActivePackage(
    SetActivePackageRequest request,
  ) async {
    _setupListeners();
    // final notifier = _ref.read(contextCollectionProvider.notifier);
    // if (request.workspaceScope != null) {
    //   final contextRoots = request.workspaceScope!.map((e) => e.path).toList();
    //   notifier.setContextCollection(contextRoots, []);
    // } else {
    //   // final roots = request.package.dependencies.map((e) => e.path).toList();
    //   final roots = [request.package.root.path];
    //   notifier.setContextCollection(roots, []);
    // }
    // await afterNewContextCollection();
    return const SetActivePackageResponse();
  }

  // Future<void> _handleSetActiveRoot(RequestMessage request) async {
  //   final response = await handleSetActivePackage(
  //       request.request as SetActivePackageRequest);

  //   sendToRunner(SidecarMessage.response(response, id: request.id));
  // }

  // Future<ContextCollectionResponse> handleAnalysisSetContextRoots(
  //   SetContextCollectionRequest request,
  // ) async {
  //   final notifier = _ref.read(contextCollectionProvider.notifier);
  //   notifier.setContextCollection(request.roots, []);
  //   await afterNewContextCollection();
  //   return const ContextCollectionResponse();
  // }

  Future<LintResponse> handleLint(LintRequest request) {
    throw StateError('LintRequest is an invalid request');
  }

  /// This method is invoked when a new instance of [AnalysisContextCollection]
  /// is created, so the plugin can perform initial analysis of analyzed files.
  ///
  /// By default analyzes every [AnalysisContext] with [analyzeFiles].
  Future<void> afterNewContextCollection() async {
    // await _forAnalysisContexts((analysisContext) async {
    final files = _ref.refresh(activeProjectScopedFilesProvider);
    // logger.info('afterNewContextCollection files: ${paths.toList()}');
    await analyzeFiles(files: files);
    // });
  }

  AnalyzedFileWithContext? _getFileWithContext(AnalyzedFile file) {
    return _ref.read(activeProjectScopedFilesProvider).firstWhereOrNull((e) =>
        file.path == e.path &&
        file.contextRoot == e.context.contextRoot.root.toUri());
  }

  AnalyzedFileWithContext? _getFileWithContextFromPath(
    String path,
    AnalysisContext context,
  ) {
    return _ref.read(activeProjectScopedFilesProvider).firstWhereOrNull((e) =>
        path == e.path &&
        context.contextRoot.root.toUri() == e.context.contextRoot.root.toUri());
  }

  // Overridden to allow for non-Dart files to be analyzed for changes
  Future<void> contentChanged(Set<AnalyzedFile> files) async {
    // logger.info('contentChanged paths: ${paths.length} $paths');
    final watch = Stopwatch()..start();

    final filesWithContexts = files.map(_getFileWithContext).whereNotNull();

    Future<void> handleContexts(List<AnalysisContext> contexts) async {
      for (final context in contexts) {
        // await _forAnalysisContexts((context) async {
        final contextPath = context.contextRoot.root.path;
        final filesInContext = filesWithContexts
            .where((file) => file.context.contextRoot.root.path == contextPath)
            .toList();
        // ignore: avoid_function_literals_in_foreach_calls
        filesInContext.forEach((e) => context.changeFile(e.path));
        final affected = await context.applyPendingFileChanges();
        final affectedWithoutOriginalPaths = affected.toSet()
          ..removeAll(filesInContext.map((e) => e.path));
        final affectedOriginalPaths = filesInContext
            .where(
                (f) => affected.any((affectedPath) => affectedPath == f.path))
            .toList();
        // for a better user experience:
        // first we handle the changed files, then we handle all affected files
        // this allows us to also include any changed non-dart files in our analysis

        await analyzeFiles(files: affectedOriginalPaths);

        // print('contentChanged abcde');
        // analyze files that may have been affected by the files that explicitly changed
        final affectedFiles = affectedWithoutOriginalPaths
            .map((e) => _getFileWithContextFromPath(e, context))
            .whereNotNull()
            .toList();
        await analyzeFiles(files: affectedFiles);
      }
    }

    // TODO: confirm this works for high/ low-priority contexts
    await handleContexts(_getPriorityContexts());

    await handleContexts(_getLowPriorityContexts());
  }

  /// PATTOBRIEN:
  /// this is where we should handle the order of events that happen post-content change
  /// i.e.:
  /// - first, analyze high priority files
  /// - second, analyze low priority files
  /// - third, check for new annotations
  /// - fourth, proactively refresh assist filters
  /// - fifth, proactively calculate edits (assists and quick fixes)
  // Future<void> handleAffectedFiles({
  //   required AnalysisContext analysisContext,
  //   required List<AnalyzedFileWithContext> files,
  // }) async {
  //   logger.info('handleAffectedFiles paths: ${files.length} $files');
  //   for (final file in files) {
  //     // _ref.invalidate(nodeRegistryForFileProvider(file));
  //     // _ref.invalidate(resolvedUnitForFileProvider(file));
  //   }
  //   // first analyze the files
  //   await analyzeFiles(files: files);
  // }

  // Future<void> _forAnalysisContexts(
  //   Future<void> Function(AnalysisContext analysisContext) f,
  // ) async {
  //   final nonPriorityAnalysisContexts = <AnalysisContext>[];
  //   final analysisContexts = _ref.read(contextCollectionProvider);
  //   print('contexts: ${analysisContexts.length}');
  //   for (final analysisContext in analysisContexts) {
  //     if (_isPriorityAnalysisContext(analysisContext)) {
  //       await f(analysisContext);
  //     } else {
  //       nonPriorityAnalysisContexts.add(analysisContext);
  //     }
  //   }

  //   for (final analysisContext in nonPriorityAnalysisContexts) {
  //     await f(analysisContext);
  //   }
  // }

  List<AnalysisContext> _getLowPriorityContexts() {
    final watch = Stopwatch()..start();
    final contexts = _ref.read(contextCollectionProvider);
    final lowPriorityContexts = contexts
        .where((context) => priorityFiles.every(
            (file) => file.contextRoot.path != context.contextRoot.root.path))
        .toList();
    return lowPriorityContexts;
  }

  List<AnalysisContext> _getPriorityContexts() {
    final contexts = _ref.read(contextCollectionProvider);
    final priorityContexts = contexts
        .where((context) => priorityFiles.any(
            (file) => file.contextRoot.path == context.contextRoot.root.path))
        .toList();
    return priorityContexts;
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
    // TODO: remove only analyzing dart files
    final dartFiles = files.where((file) => file.isDartFile);
    logger.info('${DateTime.now()} starting analyzing files: $files');
    // print('ANALYZINGFILES: ${files.length} files');

    for (final file in dartFiles) {
      Set<LintResult>? results;
      // final watch = Stopwatch()..start();

      try {
        _ref.invalidate(nodeRegistryForFileProvider(file));
        _ref.invalidate(resolvedUnitForFileProvider(file));
        final lints = await _ref.refresh(lintResultsProvider(file).future);
        results = lints;
      } catch (e) {
        // TODO: assert is throwing here.
        // rethrow;
      }

      if (results == null) continue;
      // print('analyzeFile ${file.relativePath} ${watch.elapsed.prettified()}');
      final notification = LintNotification(file.toAnalyzedFile(), results);

      // print('results: ${file.relativePath} ${notification.toJson()}');
      channel.sendNotification(notification);
      // return notification;

    }
    // }

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
    final changedPaths = <AnalyzedFile>{};

    for (final update in request.updates) {
      final watch = Stopwatch()..start();
      final filePath = update.filePath;
      print('handleUpdateFiles $filePath');
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

      changedPaths.add(update.file);
      print('handleUpdateFiles $filePath - ${watch.elapsed.prettified()}');
    }
    await contentChanged(changedPaths);
    // print('handleUpdateFiles completed - ${watch.elapsed.prettified()}');
    return const UpdateFilesResponse();
  }
}
