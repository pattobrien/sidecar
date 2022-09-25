import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/starter.dart';
import 'package:sidecar_analyzer_plugin_core/src/log_delegate/logger.dart';
import 'package:sidecar_analyzer_plugin_core/src/runner/sidecar_runner.dart';

import 'plugin/analyzer_plugin.dart';
import 'plugin/plugin.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  SidecarAnalyzerPlugin plugin, {
  required SidecarAnalyzerPluginMode mode,
}) async {
  if (mode.isDebug) {
    print('debug initialization started');
    final runner = SidecarRunner(plugin, Directory.current);
    await runner.initialize();
    print('debug initialization complete');
  } else if (mode.isCli) {
    Logger.log('cli initialization started');
    final runner = SidecarRunner(plugin, Directory.current);
    await runner.initialize();
    Logger.log('cli initialization ended');
  } else {
    // mode is plugin
    ServerPluginStarter(plugin).start(sendPort);
  }
}
