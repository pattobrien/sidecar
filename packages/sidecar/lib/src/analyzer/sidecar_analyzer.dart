// ignore_for_file: unused_result

import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart' hide LogRecord;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../configurations/sidecar_spec/sidecar_spec.dart';
import '../protocol/protocol.dart';
import '../utils/duration_ext.dart';
import '../utils/file_paths.dart';
import 'providers/providers.dart';
import '../server/communication_channel.dart';

final logger = Logger('sidecar-plugin');

T timedLog<T>(String message, T Function() function) {
  final watch = Stopwatch()..start();
  final result = function();
  logger.info('${watch.elapsed.prettified()} $message');
  return result;
}

Future<T> timedLogAsync<T>(
    String message, Future<T> Function() function) async {
  final watch = Stopwatch()..start();
  final result = await function();
  logger.info('${watch.elapsed.prettified()} $message');
  return result;
}

final sidecarAnalyzerProvider = Provider(SidecarAnalyzer.new);

class SidecarAnalyzer {
  SidecarAnalyzer(this._ref);

  final Ref _ref;

  CommunicationChannel get channel => _ref.read(communicationChannelProvider);

  Stream<dynamic> get stream =>
      _ref.read(communicationChannelStreamProvider.stream);

  OverlayResourceProvider get resourceProvider =>
      _ref.read(analyzerResourceProvider);

  Future<void> setup() async {
    _initLogger();
    _setupListeners();
    channel.sendNotification(const InitCompleteNotification());
  }

  void _initLogger() {
    logger.onRecord.listen((log) {
      final severity = LogSeverity.fromLogLevel(log.level);
      final record = LogRecord.fromAnalyzer(log.message, log.time,
          targetRoot: package.root,
          severity: severity,
          stackTrace: log.stackTrace);
      final message = SidecarMessage.log(record);
      _sendToRunner(message);
    });
  }

  void _sendToRunner(SidecarMessage message) => channel.sendMessage(message);
  ActivePackage get package => _ref.read(activePackageProvider);

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
      // ignore: avoid_types_on_closure_parameters
      onError: (Object error, StackTrace stackTrace) =>
          channel.handleError(package, error, stackTrace),
    );
    _listenForConfigChanges();
    setupCompleter.complete();
  }

  Future<void> _handleRequest(RequestMessage msg) async {
    logger.info('_handleRequest - ${msg.id}');
    final watch = Stopwatch()..start();
    final response = await msg.request.map<FutureOr<SidecarResponse?>>(
      setWorkspaceScope: handleSetCollectionRequest,
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
    logger.info('_handleRequest in ${watch.elapsed.prettified()} - ${msg.id}');
  }

  FutureOr<SetWorkspaceResponse> handleSetCollectionRequest(
    SetContextCollectionRequest request,
  ) async {
    final roots = request.roots;
    if (roots == null) {
      // scope = the entire package_config.json of the active package
      // final pubCache = Platform.environment['PUB_CACHE'];
      final activePackage = _ref.read(activePackageProvider).root;
      _ref.read(workspaceScopeProvider.notifier).update((_) => [activePackage]);
    } else {
      // scope = roots
      print('SET ROOTS: $roots');
      _ref.read(workspaceScopeProvider.notifier).update((_) => roots);
    }
    final files = _ref.refresh(activeProjectScopedFilesProvider);
    await analyzeFiles(files: files);
    return const SetWorkspaceResponse();
  }

  void _listenForConfigChanges() {
    final resourceProvider = _ref.watch(analyzerResourceProvider);
    final activePackage = _ref.read(activePackageProvider).root;
    final sidecarYamlFile =
        resourceProvider.getFile(p.join(activePackage.path, kSidecarYaml));
    sidecarYamlFile.watch().changes.listen((_) {
      _ref.invalidate(projectSidecarSpecProvider);
      final files = _ref.refresh(activeProjectScopedFilesProvider);
      analyzeFiles(files: files);
    });
  }

  SetPriorityFilesResponse handleSetPriorityFiles(
    SetPriorityFilesRequest request,
  ) {
    priorityFiles = request.files.toSet();
    return const SetPriorityFilesResponse();
  }

  Future<LintResponse> handleLint(LintRequest request) {
    throw StateError('LintRequest is an invalid request');
  }

  Future<void> contentChanged(Set<AnalyzedFile> files) async {
    Future<void> handleContexts(List<AnalysisContext> contexts) async {
      for (final context in contexts) {
        final watch = Stopwatch()..start();
        final contextUri = context.contextRoot.root.toUri();
        final changedFiles =
            files.where((f) => f.contextRoot == contextUri).toSet();

        for (final file in changedFiles) {
          logger.info('changeFile for ${contextUri.path} - ${file.path}');
          context.changeFile(file.path);
        }
        final affected = await context.applyPendingFileChanges();
        logger.info(
            'applyPendingFileChanges in ${watch.elapsed.prettified()} - ${contextUri.path}');

        // for a better user experience:
        // first we handle the changed files, then we handle all affected files.
        // this also allows us to include any changed non-dart files in our analysis
        await analyzeFiles(files: changedFiles);

        // analyze files that may have been affected by the files that explicitly changed
        final affectedFiles = affected
            .map((e) => AnalyzedFile(Uri.parse(e),
                contextRoot: context.contextRoot.root.toUri()))
            .toSet();

        await analyzeFiles(files: affectedFiles.difference(changedFiles));
        logger.info(
            'handleContexts in ${watch.elapsed.prettified()} - ${contextUri.path}');
      }
    }

    // TODO: confirm this works for high/ low-priority contexts
    await handleContexts(_getPriorityContexts());

    await handleContexts(_getLowPriorityContexts());
  }

  List<AnalysisContext> _getLowPriorityContexts() {
    final contexts = _ref.read(contextCollectionProvider);
    final lowPriorityContexts = contexts.where((context) => priorityFiles.every(
        (file) => file.contextRoot.path != context.contextRoot.root.path));
    return lowPriorityContexts.toList();
  }

  List<AnalysisContext> _getPriorityContexts() {
    final contexts = _ref.read(contextCollectionProvider);
    final priorityContexts = contexts.where((context) => priorityFiles
        .any((file) => file.contextRoot.path == context.contextRoot.root.path));
    return priorityContexts.toList();
  }

  Set<AnalyzedFile> priorityFiles = {};

  Future<void> analyzeFiles({
    required Set<AnalyzedFile> files,
  }) async {
    // TODO: remove only analyzing dart files
    final watch = Stopwatch()..start();
    final specYaml = files.firstWhereOrNull((file) => file.isSidecarYamlFile);
    if (specYaml != null) {
      // handle sidecar.yaml parse
      final contents =
          resourceProvider.getFile(specYaml.path).readAsStringSync();
      final spec = parseSidecarSpec(contents, fileUri: specYaml.fileUri);
      final exceptions = spec.errors;
      final errors = exceptions.map((e) => e.toLintResult());
      channel.sendNotification(LintNotification(specYaml, errors.toSet()));
    }

    final dartFiles = files.where((file) => file.isDartFile);

    for (final file in dartFiles) {
      _ref.invalidate(nodeRegistryForFileLintsProvider(file));

      await timedLogAsync('unit refresh',
          () => _ref.refresh(resolvedUnitForFileProvider(file).future));

      final lints = await timedLogAsync(
          'lint refresh', () => _ref.read(lintResultsProvider(file).future));

      channel.sendNotification(LintNotification(file, lints));
    }
    for (final file in dartFiles) {
      _ref.refresh(quickFixResultsProvider(file));
      _ref.refresh(assistFiltersProvider(file));
    }
    logger.info('analyzeFiles in ${watch.elapsed.prettified()} - $files');
    watch.stop();
  }

  Future<QuickFixResponse> handleEditGetFixes(
    QuickFixRequest request,
  ) async {
    final watch = Stopwatch()..start();
    final file = request.file;
    final fixes = await _ref.read(quickFixResultsProvider(file).future);
    final withinOffset =
        fixes.where((f) => f.isWithinOffset(file.path, request.offset));
    logger.info(
        'handleEditGetFixes in ${watch.elapsed.prettified()} - ${request.file.relativePath}');
    return QuickFixResponse(withinOffset.toList());
  }

  Future<AssistResponse> handleEditGetAssists(
    AssistRequest request,
  ) async {
    final watch = Stopwatch()..start();
    final file = _ref
        .read(activeProjectScopedFilesProvider)
        .firstWhereOrNull((file) => file.path == request.file.path);

    if (file == null) return const AssistResponse({});

    try {
      final assistFilterResults =
          await _ref.read(assistFiltersProvider(file).future);
      final resultsInOffest = assistFilterResults.where((element) =>
          element.isWithinOffset(request.file.path, request.offset));
      final resultsWithFixes =
          resultsInOffest.where((element) => element.editsComputer != null);
      final results = await Future.wait(resultsWithFixes.map((e) async {
        final edits = await e.editsComputer!();
        return AssistResultWithEdits(code: e.rule, span: e.span, edits: edits);
      }));
      logger.info(
          'handleEditGetAssists in ${watch.elapsed.prettified()} - ${request.file.relativePath}');
      return AssistResponse(results.toSet());
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

    final watch = Stopwatch()..start();
    for (final update in request.updates) {
      final filePath = update.filePath;
      // print('handleUpdateFiles $filePath $update');
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
    }
    await contentChanged(changedPaths);
    logger.info(
        'handleUpdateFiles $changedPaths - completed in ${watch.elapsed.prettified()}');
    return const UpdateFilesResponse();
  }
}
