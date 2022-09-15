import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/starter.dart';
import 'package:sidecar_analyzer_plugin_core/src/sidecar_runner.dart';

import 'analyzer_plugin.dart';

void startSidecarPlugin(
  SendPort sendPort,
  SidecarAnalyzerPlugin plugin, {
  bool isDebugMode = false,
}) async {
  if (isDebugMode) {
    final runner = SidecarRunner(plugin, Directory.current);
    await runner.initialize();
  } else {
    ServerPluginStarter(plugin).start(sendPort);
  }
}
