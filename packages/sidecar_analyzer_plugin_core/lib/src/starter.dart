import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/starter.dart';
import 'package:sidecar_analyzer_plugin_core/src/logger.dart';
import 'package:sidecar_analyzer_plugin_core/src/sidecar_runner.dart';

import 'analyzer_plugin.dart';

Future<void> startSidecarPlugin(
  SendPort sendPort,
  SidecarAnalyzerPlugin plugin, {
  required SidecarAnalyzerPluginMode mode,
}) async {
  if (mode == SidecarAnalyzerPluginMode.debug) {
    print('debug initialization started');
    final runner = SidecarRunner(plugin, Directory.current);
    await runner.initialize();
    print('debug initialization complete');
  } else if (mode == SidecarAnalyzerPluginMode.cli) {
    Logger.log('cli initialization started');
    final runner = SidecarRunner(plugin, Directory.current);
    await runner.initialize();
    Logger.log('cli initialization ended');
  } else {
    ServerPluginStarter(plugin).start(sendPort);
  }
}
