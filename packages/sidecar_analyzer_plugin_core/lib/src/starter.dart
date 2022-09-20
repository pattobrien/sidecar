import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/starter.dart';
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
    print('cli initialization started');
    final runner = SidecarRunner(plugin, Directory.current);
    await runner.initialize();
    print('cli initialization ended');
  } else {
    print('plugin initialization started');
    ServerPluginStarter(plugin).start(sendPort);
    print('plugin initialization complete');
  }
}
