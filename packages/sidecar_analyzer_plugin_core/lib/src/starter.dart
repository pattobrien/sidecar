import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/starter.dart';
import 'package:sidecar_analyzer_plugin_core/src/runner.dart';

import 'analyzer_plugin.dart';

const bool isDebugMode = true;

void startSidecarPlugin(SendPort sendPort, SidecarAnalyzerPlugin plugin) async {
  print('startSidecarPlugin');
  if (isDebugMode) {
    final runner = Runner(plugin, Directory.current);
    print('runner');
    await runner.initialize();
    print('runner init complete');
  } else {
    ServerPluginStarter(plugin).start(sendPort);
  }
}
