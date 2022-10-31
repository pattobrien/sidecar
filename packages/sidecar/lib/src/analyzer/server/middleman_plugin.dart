// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../protocol/constants/constants.dart';
import '../../utils/logger/logger.dart';
import '../options_provider.dart';
import 'analysis_context_providers.dart';
import 'isolates/isolates.dart';
import 'middleman_resource_provider.dart';
import 'plugin_channel_provider.dart';

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
    if (request.method == plugin.PLUGIN_REQUEST_VERSION_CHECK) {
      _handleVersionRequest(request);
    } else if (request.method == plugin.ANALYSIS_REQUEST_SET_CONTEXT_ROOTS) {
      final params = AnalysisSetContextRootsParams.fromRequest(request);
      handleAnalysisSetContextRoots(params);
      isolateService.handleServerRequest(request);
    } else if (request.method == plugin.PLUGIN_REQUEST_SHUTDOWN) {
      isolateService.handleServerRequest(request);
      isolateService.shutdownAllPlugins();
    } else {
      isolateService.handleServerRequest(request);
    }
  }

  Future<void> _handleVersionRequest(plugin.Request request) async {
    final requestTime = DateTime.now().millisecondsSinceEpoch;
    final params = plugin.PluginVersionCheckParams.fromRequest(request);
    final response = await handlePluginVersionCheck(params);
    ref
        .read(masterPluginChannelProvider)
        .sendResponse(response.toResponse(request.id, requestTime));
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    logger.finer(
        'MIDDLEMAN afterNewContextCollection || ${contextCollection.contexts.length} contexts');
    ref
        .read(allContextsProvider.state)
        .update((_) => contextCollection.contexts);
    ref.read(isolateDetailsProvider);
    ref.read(middlemanPluginIsInitializedProvider.state).update((_) => true);
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
