// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/protocol/protocol_internal.dart' as plugin;
import 'package:riverpod/riverpod.dart';
import 'package:source_span/source_span.dart';

import '../../cli/options/cli_options.dart';
import '../../protocol/constants/constants.dart';
import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';
import '../../services/active_project_service.dart';
import '../../utils/logger/logger.dart';
import '../../utils/utils.dart';
import '../context/active_context.dart';
import '../options_provider.dart';
import 'analysis_context_providers.dart';
import 'isolates/isolates.dart';
import 'isolates/multi_isolate_message.dart';
import 'middleman_resource_provider.dart';
import 'plugin_channel_provider.dart';
import 'runner/context_providers.dart';
import 'runner/runner_providers.dart';
import 'runner/sidecar_runner.dart';

class MiddlemanPluginNew extends plugin.ServerPlugin {
  MiddlemanPluginNew(this.ref)
      : super(resourceProvider: ref.read(middlemanResourceProvider));

  final Ref ref;

  @override
  String get name => kSidecarPluginName;

  @override
  String get version => kPluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => kPluginGlobs;

  @override
  plugin.PluginCommunicationChannel get channel =>
      ref.read(masterPluginChannelProvider);

  CliOptions get options => ref.read(cliOptionsProvider);

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    logger.onRecord.listen((event) {});
    logger.info('MIDDLEMAN STARTING....');
    ref.read(masterPluginChannelProvider).listen(handleAllRequests);
  }

  Future<void> handleAllRequests(
    plugin.Request request,
  ) async {
    final isIntialized =
        isRunnerInitialized.entries.every((entry) => entry.value == true);
    final requestTime = DateTime.now().microsecondsSinceEpoch;
    plugin.ResponseResult? result;
    if (isIntialized) {
      switch (request.method) {
        case plugin.ANALYSIS_REQUEST_GET_NAVIGATION:
          final params =
              plugin.AnalysisGetNavigationParams.fromRequest(request);
          result = await handleAnalysisGetNavigation(params);
          break;
        case plugin.ANALYSIS_REQUEST_HANDLE_WATCH_EVENTS:
          final params =
              plugin.AnalysisHandleWatchEventsParams.fromRequest(request);
          result = await handleAnalysisHandleWatchEvents(params);
          break;
        case plugin.ANALYSIS_REQUEST_SET_CONTEXT_ROOTS:
          final params =
              plugin.AnalysisSetContextRootsParams.fromRequest(request);
          result = await handleAnalysisSetContextRoots(params);
          break;
        case plugin.ANALYSIS_REQUEST_SET_PRIORITY_FILES:
          final params =
              plugin.AnalysisSetPriorityFilesParams.fromRequest(request);
          result = await handleAnalysisSetPriorityFiles(params);
          break;
        case plugin.ANALYSIS_REQUEST_SET_SUBSCRIPTIONS:
          final params =
              plugin.AnalysisSetSubscriptionsParams.fromRequest(request);
          result = await handleAnalysisSetSubscriptions(params);
          break;
        case plugin.ANALYSIS_REQUEST_UPDATE_CONTENT:
          final params =
              plugin.AnalysisUpdateContentParams.fromRequest(request);
          result = await handleAnalysisUpdateContent(params);
          break;
        case plugin.COMPLETION_REQUEST_GET_SUGGESTIONS:
          final params =
              plugin.CompletionGetSuggestionsParams.fromRequest(request);
          result = await handleCompletionGetSuggestions(params);
          break;
        case plugin.EDIT_REQUEST_GET_ASSISTS:
          final params = plugin.EditGetAssistsParams.fromRequest(request);
          result = await handleEditGetAssists(params);
          break;
        case plugin.EDIT_REQUEST_GET_AVAILABLE_REFACTORINGS:
          final params =
              plugin.EditGetAvailableRefactoringsParams.fromRequest(request);
          result = await handleEditGetAvailableRefactorings(params);
          break;
        case plugin.EDIT_REQUEST_GET_FIXES:
          final params = plugin.EditGetFixesParams.fromRequest(request);
          result = await handleEditGetFixes(params);
          break;
        case plugin.EDIT_REQUEST_GET_REFACTORING:
          final params = plugin.EditGetRefactoringParams.fromRequest(request);
          result = await handleEditGetRefactoring(params);
          break;
        case plugin.KYTHE_REQUEST_GET_KYTHE_ENTRIES:
          final params = plugin.KytheGetKytheEntriesParams.fromRequest(request);
          result = await handleKytheGetKytheEntries(params);
          break;
        case plugin.PLUGIN_REQUEST_SHUTDOWN:
          final params = plugin.PluginShutdownParams();
          result = await handlePluginShutdown(params);
          channel.sendResponse(result.toResponse(request.id, requestTime));
          channel.close();
          break;
        case plugin.PLUGIN_REQUEST_VERSION_CHECK:
          final params = plugin.PluginVersionCheckParams.fromRequest(request);
          result = await handlePluginVersionCheck(params);
          break;
      }
      if (result == null) {
        final response = plugin.Response(request.id, requestTime,
            error: plugin.RequestErrorFactory.unknownRequest(request.method));
        return channel.sendResponse(response);
      }
      final response = result.toResponse(request.id, requestTime);
      channel.sendResponse(response);
    } else {
      queuedRequests.add(request);
    }
  }

  /// Handle an 'edit.getFixes' request.
  ///
  /// Throw a [plugin.RequestFailure] if the request could not be handled.
  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final runners = ref.watch(runnersProvider);
    final responses = await Future.wait(runners.map((runner) async {
      final file = runner.getAnalyzedFileForPath(parameters.file);
      if (file == null) return null;
      final request = QuickFixRequest(file: file, offset: parameters.offset);
      return runner.asyncRequest<QuickFixResponse>(request);
    }));
    final fixes = responses
        .whereType<QuickFixResponse>()
        .map((response) => response.toPluginResponse())
        .expand((result) => result.fixes)
        .toList();
    return plugin.EditGetFixesResult(fixes);
  }

  /// Handle an 'analysis.handleWatchEvents' request.
  ///
  /// Throw a [plugin.RequestFailure] if the request could not be handled.
  @override
  Future<plugin.AnalysisHandleWatchEventsResult>
      handleAnalysisHandleWatchEvents(
    plugin.AnalysisHandleWatchEventsParams parameters,
  ) async {
    for (final event in parameters.events) {
      switch (event.type) {
        case plugin.WatchEventType.ADD:
          // TODO(brianwilkerson) Handle the event.
          break;
        case plugin.WatchEventType.MODIFY:
          await contentChanged([event.path]);
          break;
        case plugin.WatchEventType.REMOVE:
          // TODO(brianwilkerson) Handle the event.
          break;
        default:
          // Ignore unhandled watch event types.
          break;
      }
    }
    return plugin.AnalysisHandleWatchEventsResult();
  }

  /// Handle an 'edit.getAssists' request.
  ///
  /// Throw a [plugin.RequestFailure] if the request could not be handled.
  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    plugin.EditGetAssistsParams parameters,
  ) async {
    final runners = ref.watch(runnersProvider);
    final responses = await Future.wait(runners.map((runner) async {
      final file = runner.getAnalyzedFileForPath(parameters.file);
      if (file == null) return null;
      final request = AssistRequest(
          file: file, offset: parameters.offset, length: parameters.length);
      return runner.asyncRequest<AssistResponse>(request);
    }));

    final parsedResponses = responses
        .whereType<AssistResponse>()
        .map((response) => response.results
            .map((e) => e.toPrioritizedSourceChanges())
            .expand((e) => e)
            .toList())
        .expand((e) => e);
    return plugin.EditGetAssistsResult(parsedResponses.toList());
  }

  @override
  Future<plugin.AnalysisUpdateContentResult> handleAnalysisUpdateContent(
    plugin.AnalysisUpdateContentParams parameters,
  ) async {
    final runners = ref.read(runnersProvider);
    final responses = await Future.wait(runners.map((runner) async {
      final events = parameters.files.entries
          .map((entry) {
            final analyzedFile = runner.getAnalyzedFileForPath(entry.key);
            if (analyzedFile == null) return null;
            final contentOverlay = entry.value;
            if (contentOverlay is plugin.AddContentOverlay) {
              return FileUpdateEvent.add(analyzedFile, contentOverlay.content);
            }
            if (contentOverlay is plugin.ChangeContentOverlay) {
              final edits = contentOverlay.edits.map((e) {
                final start =
                    SourceLocation(e.offset, sourceUrl: analyzedFile.fileUri);
                final end = SourceLocation(e.offset + e.length,
                    sourceUrl: analyzedFile.fileUri);
                final originalText = ' ' * (e.length);
                final span = SourceSpan(start, end, originalText);
                return SourceEdit(
                    originalSourceSpan: span, replacement: e.replacement);
              }).toList();
              final sourceFileEdit = SourceFileEdit(
                  file: analyzedFile.fileUri,
                  fileStamp: DateTime.now(),
                  edits: edits);
              return FileUpdateEvent.modify(analyzedFile, sourceFileEdit);
            } else if (contentOverlay is plugin.RemoveContentOverlay) {
              return FileUpdateEvent.delete(analyzedFile);
            } else {
              throw UnimplementedError('INVALID OVERLAY');
            }
          })
          .whereType<FileUpdateEvent>()
          .toList();

      final messages =
          await Future.wait<UpdateFilesResponse>(runners.map((runner) async {
        final runnerEvents = events.where((event) {
          return runner.allContexts.contextForPath(event.filePath) != null;
        }).toList();

        final sidecarRequest = SidecarRequest.updateFiles(runnerEvents);
        return runner.asyncRequest<UpdateFilesResponse>(sidecarRequest);
      }));
    }));
    return plugin.AnalysisUpdateContentResult();
  }

  final queuedRequests = <plugin.Request>[];
  final isRunnerInitialized = <SidecarRunner, bool>{};
  final state = <String, MultiIsolateMessage>{};

  void dumpRequests() {
    logger.finer('dumpRequests = ${queuedRequests.length}');
    // ignore: prefer_foreach
    for (final request in queuedRequests
      ..sort((a, b) => a.id.compareTo(b.id))) {
      handleAllRequests(request);
    }
  }

  @override
  Future<void> beforeContextCollectionDispose({
    required AnalysisContextCollection contextCollection,
  }) async {
    //
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    logger.finer(
        'MIDDLEMAN afterNewContextCollection || ${contextCollection.contexts.length} contexts');
    final service = ref.read(activeProjectServiceProvider);

    final activeContexts = contextCollection.contexts
        .map((e) => service.getActiveContext(e, contextCollection.contexts))
        .whereType<ActiveContext>()
        .toList();

    ref.read(runnerActiveContextsProvider.notifier).update = activeContexts;
    final runners = ref.read(runnersProvider);

    await Future.wait(runners.map((runner) async {
      isRunnerInitialized[runner] = false;
      runner.lints.listen((lint) {
        channel.sendNotification(lint.toPluginNotification());
      });
      runner.logs.listen((event) => _log(runner, event));
      logger.onRecord.listen(
          (event) => _logMiddleman(runner, LogRecord.simple(event.toString())));
      await runner.initialize();
      await runner.requestSetContext();
      isRunnerInitialized[runner] = true;
    }));
    dumpRequests();
    ref
        .read(allContextsProvider.state)
        .update((_) => contextCollection.contexts);
    // ref.read(isolateDetailsProvider);
    // ref.read(middlemanPluginIsInitializedProvider.state).update((_) => true);
  }

  void _logMiddleman(SidecarRunner runner, LogRecord log) {
    final message = log.when(
      simple: (message) => message,
      fromAnalyzer: (mainContext, timestamp, severity, message, stack) {
        return '$timestamp [${severity.name.toUpperCase()}] $message';
      },
      fromRule: (lintCode, message) {
        return 'LINTCODE LOG: $message';
      },
    );
    channel.sendError(message);
  }

  void _log(SidecarRunner runner, LogRecord log) {
    final runnerName = runner.context.activeRoot.root.shortName;
    final message = log.when(
      simple: (message) => message,
      fromAnalyzer: (mainContext, timestamp, severity, message, stack) {
        return '$timestamp [${severity.name}] $runnerName $message';
      },
      fromRule: (lintCode, message) {
        return 'LINTCODE LOG: $message';
      },
    );
    channel.sendError(message);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {}
}

final middlemanPluginProvider = Provider<MiddlemanPluginNew>(
  (ref) {
    return MiddlemanPluginNew(ref);
  },
  name: 'middlemanPluginProvider',
  dependencies: [
    cliOptionsProvider,
    // isolateDetailsProvider,
    masterPluginChannelProvider,
    allContextsProvider,
    // isolateCommunicationServiceProvider,
    middlemanResourceProvider,
    // middlemanPluginIsInitializedProvider,
  ],
);
