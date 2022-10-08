// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_builder.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:pubspec_lock_parse/pubspec_lock_parse.dart' as pubspec_lock;

import '../../sidecar_analyzer_plugin_core.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/plugin_generator/project_service.dart';
import 'middleman_server_isolate.dart';
import 'package:sidecar/sidecar.dart';

final middlemanPluginProvider = Provider((ref) {
  return MiddlemanPlugin(ref);
});

const middlemanPluginVersion = '0.1.21-dev.11';

class MiddlemanPlugin extends plugin.ServerPlugin {
  MiddlemanPlugin(
    this._ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  final initializationCompleter = Completer<void>();
  final Ref _ref;

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => pluginGlobs;

  SidecarAnalyzerMode get mode => _ref.read(sidecarAnalyzerMode);
  LogDelegateBase get delegate => _ref.read(logDelegateProvider);

  AnalysisContextService getAnalysisContextService(AnalysisContext context) =>
      _ref.read(analysisContextServiceProvider(context));

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    delegate.sidecarMessage('MIDDLEMAN STARTING....');
    _start(channel);
  }

  Future<void> _start(
    plugin.PluginCommunicationChannel channel,
  ) async {
    if (mode.isDebug) await _startWithHotReload(channel);
    _ref.read(masterPluginChannelProvider).listen(sendRequest);
  }

  void sendRequest(plugin.Request request) {
    if (request.method == plugin.ANALYSIS_REQUEST_SET_CONTEXT_ROOTS) {
      _handleContextRequest(request);
    }
    if (request.method == plugin.PLUGIN_REQUEST_VERSION_CHECK) {
      _handleVersionRequest(request);
    }
  }

  Future<void> _handleVersionRequest(plugin.Request request) async {
    final requestTime = DateTime.now().millisecondsSinceEpoch;
    final params = plugin.PluginVersionCheckParams.fromRequest(request);
    final response = await handlePluginVersionCheck(params);
    final id = request.id;
    _ref
        .read(masterPluginChannelProvider)
        .sendResponse(response.toResponse(id, requestTime));
  }

  @override
  Future<void> beforeContextCollectionDispose({
    required AnalysisContextCollection contextCollection,
  }) async {}

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    await Future.wait(contextCollection.contexts.map((context) async {
      final rootPath = context.contextRoot.root.path;
      delegate
          .sidecarMessage('MIDDLEMAN: setting up context at root: $rootPath');
      if (context.isSidecarEnabled) {
        delegate.sidecarMessage(
            'MIDDLEMAN: sidecar not enabled at root: $rootPath');
        return;
      }
      final serverIsolate =
          _ref.read(middlemanServerIsolateProvider(context.contextRoot));
      if (serverIsolate.doesAlreadyExist()) {
        delegate.sidecarMessage('MIDDLEMAN: context already exists $rootPath');
        // TODO: reset isolate so it can check for any new changes, e.g. to pubspec, analysis options, etc
      }
      // else {
      delegate.sidecarMessage(
          'MIDDLEMAN $rootPath - setting up plugin source files');
      await serverIsolate.setupPluginSourceFiles();
      delegate.sidecarMessage(
          'MIDDLEMAN $rootPath - setup plugin source files completed  - initializing isolate...');
      await serverIsolate.initializeIsolate();
      delegate.sidecarMessage(
          'MIDDLEMAN $rootPath - setup plugin source files completed  - initializing isolate complete');
      // }
    }));
  }

  Future<void> _handleContextRequest(plugin.Request request) async {
    final params = plugin.AnalysisSetContextRootsParams.fromRequest(request);
    await handleAnalysisSetContextRoots(params);
    // await Future.wait(params.roots.map((root) async {
    //   delegate.sidecarMessage(
    //       'MIDDLEMAN: setting up context at root: ${root.root}');
    //   //
    //   final uri = Uri.parse(root.root);
    //   final serverIsolate = _ref.read(middlemanServerIsolateProvider(uri));
    //   if (serverIsolate.doesAlreadyExist()) {
    //     delegate
    //         .sidecarMessage('MIDDLEMAN: context already exists ${root.root}');
    //     // TODO: reset isolate so it can check for any new changes, e.g. to pubspec, analysis options, etc
    //   }
    //   // else {
    //   delegate.sidecarMessage(
    //       'MIDDLEMAN ${root.root} - setting up plugin source files');
    //   await serverIsolate.setupPluginSourceFiles();
    //   delegate.sidecarMessage(
    //       'MIDDLEMAN ${root.root} - setup plugin source files completed  - initializing isolate...');
    //   await serverIsolate.initializeIsolate();
    //   delegate.sidecarMessage(
    //       'MIDDLEMAN ${root.root} - setup plugin source files completed  - initializing isolate complete');
    //   // }
    // }));
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        _ref
            .read(masterPluginChannelProvider)
            .sendNotification(plugin.Notification('sidecar.auto_reload', {}));
      }
    });
  }

  Future<void> reload() async {
    await _reloader?.reloadCode();
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {}
}
