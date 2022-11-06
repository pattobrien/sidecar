// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/protocol/protocol_internal.dart' as plugin;
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/analyzer/server/runner/context_providers.dart';
import 'package:source_span/source_span.dart';

import '../../../sidecar.dart';
import '../../cli/options/cli_options.dart';
import '../../protocol/constants/constants.dart';
import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';
import '../../protocol/source/source_file_edit.dart';
import '../../services/active_project_service.dart';
import '../../utils/logger/logger.dart';
import '../context/active_context.dart';
import '../options_provider.dart';
import 'analysis_context_providers.dart';
import 'isolates/isolates.dart';
import 'middleman_resource_provider.dart';
import 'plugin_channel_provider.dart';
import 'runner/runner_providers.dart';

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

  IsolateCommunicationService get isolateService =>
      ref.read(isolateCommunicationServiceProvider);

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    logger.finer('MIDDLEMAN STARTING....');
    _start(channel);
  }

  Future<void> _start(
    plugin.PluginCommunicationChannel channel,
  ) async {
    // if (analyzerMode.isDebug) await _startWithHotReload(channel);
    ref.read(masterPluginChannelProvider).listen(sendRequest);
  }

  void sendRequest(plugin.Request request) {
    // if (request.method == plugin.PLUGIN_REQUEST_VERSION_CHECK) {
    //   _handleVersionRequest(request);
    // } else if (request.method == plugin.ANALYSIS_REQUEST_SET_CONTEXT_ROOTS) {
    //   final params = plugin.AnalysisSetContextRootsParams.fromRequest(request);
    //   handleAnalysisSetContextRoots(params);
    //   // isolateService.handleServerRequest(request);
    // } else if (request.method == plugin.PLUGIN_REQUEST_SHUTDOWN) {
    //   isolateService.handleServerRequest(request);
    //   isolateService.shutdownAllPlugins();
    // } else {
    // isolateService.handleServerRequest(request);
    handleAllRequests(request);
    // }
  }

  Future<void> handleAllRequests(plugin.Request request) async {
    final response =
        await _getResponse(request, DateTime.now().microsecondsSinceEpoch);
    if (response == null) return;
    channel.sendResponse(response);
  }

  // Future<void> _handleVersionRequest(plugin.Request request) async {
  //   final requestTime = DateTime.now().millisecondsSinceEpoch;
  //   final params = plugin.PluginVersionCheckParams.fromRequest(request);
  //   final response = await handlePluginVersionCheck(params);
  //   channel.sendResponse(response.toResponse(request.id, requestTime));
  // }

  Future<SidecarResponse> _sendToSingleRunner(
    SidecarRequest request,
    String path,
  ) async {
    final allRunners = await ref.read(getRunnersProvider.future);
    final runner = allRunners.singleWhere(
        (runner) => runner.allContexts.contextForPath(path) != null);
    // for (final runner in applicableRunners) {
    final response = await runner.asyncRequest(request);
    return response;
    // }
  }

  Future<plugin.Response?> _getResponse(
    plugin.Request request,
    int requestTime,
  ) async {
    plugin.ResponseResult? result;
    switch (request.method) {
      case plugin.ANALYSIS_REQUEST_GET_NAVIGATION:
        final params = plugin.AnalysisGetNavigationParams.fromRequest(request);
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
      // throw UnimplementedError('handling contexts should happen elsewhere');

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
        final params = plugin.AnalysisUpdateContentParams.fromRequest(request);
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
        // _channel.sendResponse(result.toResponse(request.id, requestTime));
        // _channel.close();
        return null;
      case plugin.PLUGIN_REQUEST_VERSION_CHECK:
        final params = plugin.PluginVersionCheckParams.fromRequest(request);
        result = await handlePluginVersionCheck(params);
        break;
    }
    if (result == null) {
      return plugin.Response(request.id, requestTime,
          error: plugin.RequestErrorFactory.unknownRequest(request.method));
    }
    return result.toResponse(request.id, requestTime);
  }

  @override
  Future<plugin.AnalysisUpdateContentResult> handleAnalysisUpdateContent(
    plugin.AnalysisUpdateContentParams parameters,
  ) async {
    final events = parameters.files.entries.map((entry) {
      final fileUri = Uri.parse(entry.key);
      final contentOverlay = entry.value;
      if (contentOverlay is plugin.AddContentOverlay) {
        return FileUpdateEvent.add(fileUri, contentOverlay.content);
      }
      if (contentOverlay is plugin.ChangeContentOverlay) {
        final edits = contentOverlay.edits.map((e) {
          final start = SourceLocation(e.offset, sourceUrl: fileUri);
          final end = SourceLocation(e.offset + e.length, sourceUrl: fileUri);
          final originalText = ' ' * (e.length);
          final span = SourceSpan(start, end, originalText);
          return SourceEdit(
              originalSourceSpan: span, replacement: e.replacement);
        }).toList();
        final sourceFileEdit = SourceFileEdit(
            file: fileUri, fileStamp: DateTime.now(), edits: edits);
        return FileUpdateEvent.modify(sourceFileEdit);
      } else if (contentOverlay is plugin.RemoveContentOverlay) {
        return FileUpdateEvent.delete(fileUri);
      } else {
        throw UnimplementedError('INVALID OVERLAY');
      }
    }).toList();

    final allRunners = await ref.read(getRunnersProvider.future);
    final messages =
        await Future.wait<UpdateFilesResponse>(allRunners.map((runner) async {
      final runnerEvents = events.where((event) {
        return runner.allContexts.contextForPath(event.filePath) != null;
      }).toList();

      final sidecarRequest = SidecarRequest.updateFiles(runnerEvents);
      return runner.asyncRequest<UpdateFilesResponse>(sidecarRequest);
    }));
    // final anyErrors = messages.every((msg) => msg is! SidecarResponse);
    // assert(!anyErrors, 'errors received');
    return plugin.AnalysisUpdateContentResult();
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
    final runners = await ref.read(getRunnersProvider.future);

    await Future.wait(runners.map((runner) async {
      runner.notifications.listen((notification) {
        notification.map(
          initComplete: (initComplete) => null,
          lint: (lint) => channel.sendNotification(lint.toPluginNotification()),
        );
      });
      runner.logs.listen((event) {
        // final msg = event.map(
        //     simple: simple, fromAnalyzer: fromAnalyzer, fromRule: fromRule,);
        final runnerName = runner.context.activeRoot.root.shortName;
        channel.sendError('RUNNER $runnerName: ${event.toJson()}');
        _log(event, runner.context.activeRoot.root.path);
      });
      // return runner.initialize();
    }));

    ref
        .read(allContextsProvider.state)
        .update((_) => contextCollection.contexts);
    ref.read(isolateDetailsProvider);
    ref.read(middlemanPluginIsInitializedProvider.state).update((_) => true);
  }

  void _log(LogRecord log, String path) {
    final file = File(join(path, kDartTool, 'sidecar_logs', 'log.txt'));
    if (!file.existsSync()) file.createSync(recursive: true);
    file.writeAsStringSync('${log.toJson()}\n', mode: FileMode.append);
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
    isolateDetailsProvider,
    masterPluginChannelProvider,
    allContextsProvider,
    isolateCommunicationServiceProvider,
    middlemanResourceProvider,
    middlemanPluginIsInitializedProvider,
  ],
);

final middlemanPluginIsInitializedProvider =
    StateProvider<bool>((ref) => false);
