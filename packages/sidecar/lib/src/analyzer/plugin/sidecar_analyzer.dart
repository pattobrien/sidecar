import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart' hide LogRecord;
import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/requests/requests.dart';
import '../../protocol/responses/responses.dart';
import '../../protocol/source/source_edit.dart';
import '../../utils/duration_ext.dart';
import '../context/analyzed_file.dart';
import 'active_package_provider.dart';
import 'collection_provider.dart';
import 'files_provider.dart';
import 'plugin.dart';
import 'resolved_unit_provider.dart';
import 'results_providers.dart';

final logger = Logger('sidecar-plugin');

final sidecarAnalyzerProvider = Provider(SidecarAnalyzer.new);

class SidecarAnalyzer {
  SidecarAnalyzer(this._ref);

  final Ref _ref;

  CommunicationChannel get channel => _ref.read(communicationChannelProvider);

  Stream<dynamic> get stream =>
      _ref.read(communitcationChannelStreamProvider.stream);

  OverlayResourceProvider get resourceProvider =>
      _ref.read(analyzerResourceProvider);

  Future<void> setup(
      // CommunicationChannel channel,
      ) async {
    // this.channel = channel;
    _initLogger();
    _setupListeners();
    await afterNewContextCollection();
  }

  void _initLogger() {
    logger.onRecord.listen((log) {
      final severity = LogSeverity.fromLogLevel(log.level);
      final package = _ref.read(activePackageProvider).value!;
      final record = LogRecord.fromAnalyzer(log.message, log.time,
          context: package, severity: severity, stackTrace: log.stackTrace);
      final message = SidecarMessage.log(record);
      _sendToRunner(message);
    });
  }

  void _sendToRunner(SidecarMessage message) => channel.sendMessage(message);

  void _handleError(Object error, StackTrace stack) {
    final package = _ref.read(activePackageProvider).value!;
    final log = LogRecord.fromAnalyzer(error.toString(), DateTime.now(),
        severity: LogSeverity.error, context: package, stackTrace: stack);
    final message = SidecarMessage.log(log);
    channel.sendMessage(message);
  }

  final setupCompleter = Completer<void>();

  void _setupListeners() {
    if (setupCompleter.isCompleted) return;
    stream.listen(
      (dynamic event) {
        assert(event is String, 'incorrect type: ${event.runtimeType} $event');
        try {
          final json = jsonDecode(event as String) as Map<String, dynamic>;
          final message = RequestMessage.fromJson(json);
          _handleRequest(message);
        } catch (e) {
          throw UnimplementedError('invalid message type: $e');
        }
      },
      onError: _handleError,
    );
    setupCompleter.complete();
  }

  Future<void> _handleRequest(RequestMessage msg) async {
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
      _sendToRunner(responseMessage);
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
    return const SetActivePackageResponse();
  }

  Future<LintResponse> handleLint(LintRequest request) {
    throw StateError('LintRequest is an invalid request');
  }

  /// This method is invoked when a new instance of [AnalysisContextCollection]
  /// is created, so the plugin can perform initial analysis of analyzed files.
  ///
  /// By default analyzes every [AnalysisContext] with [analyzeFiles].
  Future<void> afterNewContextCollection() async {
    final files = _ref.refresh(activeProjectScopedFilesProvider);
    await analyzeFiles(files: files);
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

  /// PATTOBRIEN:
  /// this is where we should handle the order of events that happen post-content change
  /// i.e.:
  /// - first, analyze high priority files
  /// - second, analyze low priority files
  /// - third, check for new annotations
  /// - fourth, proactively refresh assist filters
  /// - fifth, proactively calculate edits (assists and quick fixes)
  // Overridden to allow for non-Dart files to be analyzed for changes
  Future<void> contentChanged(Set<AnalyzedFile> files) async {
    final filesWithContexts = files.map(_getFileWithContext).whereNotNull();

    Future<void> handleContexts(List<AnalysisContext> contexts) async {
      for (final context in contexts) {
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

  List<AnalysisContext> _getLowPriorityContexts() {
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

  Set<AnalyzedFile> priorityFiles = {};

  Future<void> analyzeFiles({
    required List<AnalyzedFileWithContext> files,
  }) async {
    // TODO: remove only analyzing dart files
    final dartFiles = files.where((file) => file.isDartFile);
    logger.info('starting analyzeFiles: $files');

    for (final file in dartFiles) {
      _ref.invalidate(nodeRegistryForFileProvider(file));
      _ref.invalidate(resolvedUnitForFileProvider(file));
      final lints = await _ref.refresh(lintResultsProvider(file).future);
      final notification = LintNotification(file.toAnalyzedFile(), lints);

      channel.sendNotification(notification);
    }

    logger.finest('finished analyzeFiles');
  }

  Future<QuickFixResponse> handleEditGetFixes(
    QuickFixRequest request,
  ) async {
    final contexts = _ref.read(contextCollectionProvider);
    final file = AnalyzedFileWithContext.fromFile(request.file, contexts);
    final fixes = await _ref.read(quickFixResultsProvider(file).future);
    return QuickFixResponse(fixes);
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
      // print('handleUpdateFiles $filePath');
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
