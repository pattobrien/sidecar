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
import '../../services/active_project_service_new.dart';
import '../../utils/logger/logger.dart';
import '../../utils/utils.dart';
import '../context/active_context.dart';
import '../context/analyzed_file.dart';
import '../options_provider.dart';
import 'analysis_context_providers.dart';
import 'isolates/isolate_communication_service.dart';
import 'isolates/multi_isolate_message.dart';
import 'middleman_resource_provider.dart';
import 'plugin_channel_provider.dart';
import 'runner/context_providers.dart';
import 'runner/runner_providers.dart';
import 'runner/sidecar_runner.dart';

class MiddlemanPlugin extends plugin.ServerPlugin {
  MiddlemanPlugin(this.ref)
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
    logger.info('PLUGIN STARTING....');
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

  // /// Handle an 'edit.getFixes' request.
  // ///
  // /// Throw a [plugin.RequestFailure] if the request could not be handled.
  // @override
  // Future<plugin.EditGetFixesResult> handleEditGetFixes(
  //   plugin.EditGetFixesParams parameters,
  // ) async {
  //   final runners = ref.watch(runnersProvider);
  //   final responses = await Future.wait(runners.map((runner) async {
  //     final file = runner.getAnalyzedFile(parameters.file);
  //     if (file == null) return null;
  //     final request = QuickFixRequest(file: file, offset: parameters.offset);
  //     return runner.asyncRequest<QuickFixResponse>(request);
  //   }));
  //   final fixes = responses
  //       .whereType<QuickFixResponse>()
  //       .map((response) => response.toPluginResponse())
  //       .expand((result) => result.fixes)
  //       .toList();
  //   return plugin.EditGetFixesResult(fixes);
  // }

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

  // /// Handle an 'edit.getAssists' request.
  // ///
  // /// Throw a [plugin.RequestFailure] if the request could not be handled.
  // @override
  // Future<plugin.EditGetAssistsResult> handleEditGetAssists(
  //   plugin.EditGetAssistsParams parameters,
  // ) async {
  //   final runnerFiles = getRunnersForPath(parameters.file);
  //   final responses =
  //       await Future.wait(runnerFiles.entries.map((runnerFile) async {
  //     final request = AssistRequest(
  //         file: runnerFile.value,
  //         offset: parameters.offset,
  //         length: parameters.length);
  //     return runnerFile.key.asyncRequest<AssistResponse>(request);
  //   }));

  //   final parsedResponses = responses
  //       .whereType<AssistResponse>()
  //       .map((response) => response.results
  //           .map((e) => e.toPrioritizedSourceChanges())
  //           .expand((e) => e)
  //           .toList())
  //       .expand((e) => e);
  //   return plugin.EditGetAssistsResult(parsedResponses.toList());
  // }

  @override
  Future<plugin.AnalysisUpdateContentResult> handleAnalysisUpdateContent(
    plugin.AnalysisUpdateContentParams parameters,
  ) async {
    final runners = ref.read(runnersProvider);
    await Future.wait(runners.map((runner) async {
      print('MM handleAnalysisUpdateContent');
      final events = parameters.files.entries
          .map((entry) {
            final analyzedFile = runner.getAnalyzedFile(entry.key);
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

      await Future.wait<UpdateFilesResponse>(runners.map((runner) async {
        final runnerEvents = events.where((event) {
          return runner.allContexts.contextForPath(event.filePath) != null;
        }).toList();

        // for (final event in runnerEvents) {
        //   final sWatch = Stopwatch()..start();
        //   final path = event.filePath;
        //   runner.lints.listen((event) {
        //     if (event.file.path == path) {
        //       print('lint received in ${sWatch.elapsed.prettified()}');
        //     }
        //   });
        // }
        print(
            'updateFilesRequest: ${runnerEvents.map((e) => e.filePath).toList()}');
        final sidecarRequest = SidecarRequest.updateFiles(runnerEvents);

        print('MM handleAnalysisUpdateContent asyncRequest start');
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
    final orderedRequests = queuedRequests
      ..sort((a, b) => a.id.compareTo(b.id));
    orderedRequests.forEach(handleAllRequests);
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    logger.finer(
        'MIDDLEMAN afterNewContextCollection || ${contextCollection.contexts.length} contexts');
    final service = ref.read(activeProjectServiceNewProvider);
    final activeContexts =
        service.getActivePackagesFromCollection(contextCollection);
    ref.read(runnerActiveContextsProvider.notifier).update =
        activeContexts.toList();
    final runners = ref.read(runnersProvider);

    await Future.wait(runners.map((runner) async {
      isRunnerInitialized[runner] = false;
      runner.notifications.listen((notification) {
        notification.map(
          initComplete: (_) => null,
          lint: (lint) => channel.sendNotification(lint.toPluginNotification()),
        );
      });
      runner.logs.listen((event) => _log(runner, event));
      logger.onRecord.listen(
          (event) => _logMiddleman(runner, LogRecord.simple(event.toString())));

      final workspaceScope = contextCollection.contexts
          .map((e) => e.contextRoot.root.toUri())
          .toList();
      await runner.initialize();
      isRunnerInitialized[runner] = true;
    }));
    dumpRequests();
    ref
        .read(allContextsProvider.state)
        .update((_) => contextCollection.contexts);
    // ref.read(isolateDetailsProvider);
    // ref.read(middlemanPluginIsInitializedProvider.state).update((_) => true);
  }

  List<SidecarRunner> get runners => ref.read(runnersProvider);

  /// Handle an 'analysis.setPriorityFiles' request.
  ///
  /// Throw a [plugin.RequestFailure] if the request could not be handled.
  @override
  Future<plugin.AnalysisSetPriorityFilesResult> handleAnalysisSetPriorityFiles(
    plugin.AnalysisSetPriorityFilesParams parameters,
  ) async {
    priorityPaths = parameters.files.toSet();
    final filesForRunners = getRunnersForPaths(parameters.files);
    assert(filesForRunners.length >= 3, 'toSet() isnt working for runners');

    for (final runnerFiles in filesForRunners.entries) {
      final files = runnerFiles.value;
      final request = SidecarRequest.setPriorityFiles(files);
      await runnerFiles.key.asyncRequest(request);
    }
    return plugin.AnalysisSetPriorityFilesResult();
  }

  Map<SidecarRunner, Set<AnalyzedFile>> getRunnersForPaths(List<String> paths) {
    return {
      for (final runner in runners)
        runner:
            paths.map(runner.getAnalyzedFile).whereType<AnalyzedFile>().toSet(),
    };
  }

  Map<SidecarRunner, AnalyzedFile> getRunnersForPath(String path) {
    final runnersWithFiles = {
      for (final runner in runners) runner: runner.getAnalyzedFile(path)
    }..removeWhere((key, value) => value == null);
    return {
      for (final entry in runnersWithFiles.entries) entry.key: entry.value!
    };
  }

  // List<SidecarRunner> getRunnersForPath(String path) {
  //   return runners
  //       .where((element) => element.getAnalyzedFileForPath(path) != null)
  //       .toList();
  // }

  void _logMiddleman(SidecarRunner runner, LogRecord log) {
    final message = log.when(
      simple: (message) => '[MIDDLEMAN] $message',
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
    final runnerName = runner.context.root.pathSegments.last;
    final message = log.when(
      simple: (message) => 'simple log: $message',
      fromAnalyzer: (mainContext, timestamp, severity, message, stack) {
        return '$timestamp [$runnerName] [${severity.name.toUpperCase()}] $message $stack';
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

final middlemanPluginProvider = Provider<MiddlemanPlugin>(
  (ref) {
    return MiddlemanPlugin(ref);
  },
  name: 'middlemanPluginProvider',
  dependencies: [
    cliOptionsProvider,
    masterPluginChannelProvider,
    allContextsProvider,
    isolateCommunicationServiceProvider,
    middlemanResourceProvider,
  ],
);
