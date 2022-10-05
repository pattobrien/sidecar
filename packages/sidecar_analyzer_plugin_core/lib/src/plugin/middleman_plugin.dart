import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/instrumentation/instrumentation.dart';

import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:cli_util/cli_util.dart';

import 'package:hotreloader/hotreloader.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:uuid/uuid.dart';

import '../../sidecar_analyzer_plugin_core.dart';
import '../application/rules/activated_rules_notifier.dart';
import '../constants.dart';
import '../context_services/context_services.dart';
import '../services/analysis_context_collection_service/analysis_context_collection_service.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/project_configuration_service/providers.dart';
import 'analyzer_mode.dart';
import 'package:path/path.dart' as p;
import '../utils/byte_store_ext.dart';

final middlemanPluginProvider = Provider(MiddlemanPlugin.new);

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
    // super.start(channel);
  }

  Future<void> _runProcess() async {
    delegate.sidecarMessage('MM: _runProcess()');
    final root = p.join(
        Platform.environment['HOME']!,
        '.dartServer',
        'sidecar_analyzer_plugin',
        'my_analyzed_codebase',
        'sidecar_analyzer_plugin_core');

    final packagesPath = p.join(
        root, 'tools', 'analyzer_plugin', '.dart_tool', 'package_config.json');
    final executionPath =
        p.join(root, 'tools', 'analyzer_plugin', 'bin', 'sidecar.dart');

    final chann = plugin.ServerIsolateChannel.discovered(
      Uri.file(executionPath, windows: Platform.isWindows),
      Uri.file(packagesPath, windows: Platform.isWindows),
      NoopInstrumentationService(),
    );
    await chann.listen(
      (response) {
        // delegate
        //     .sidecarMessage('TESTRESPONSE: ${response.toJson().toString()}');
        _ref.read(pluginChannelProvider).sendResponse(response);
      },
      (notification) {
        // delegate.sidecarMessage(
        //     'TESTNOTIFICATION: ${notification.toJson().toString()}');
        _ref.read(pluginChannelProvider).sendNotification(notification);
      },
      onDone: () {
        delegate.sidecarMessage('TESTDONE');
      },
      onError: (error) {
        delegate.sidecarMessage('TESTERROR: ${error.toString()}');
      },
    );

    _ref.read(pluginChannelProvider).listen(chann.sendRequest);
    delegate.sidecarMessage('MM: _runProcess() COMPLETED');
  }

  Future<void> _start(
    plugin.PluginCommunicationChannel channel,
  ) async {
    await _runProcess();
    if (mode.isDebug) await _startWithHotReload(channel);
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        channel.sendNotification(
          plugin.Notification('sidecar.auto_reload', {}),
        );
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
  }) async {
    // do nothing

    throw UnimplementedError();
  }
}
