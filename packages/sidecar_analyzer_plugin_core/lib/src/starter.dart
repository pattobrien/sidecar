import 'dart:isolate';

import 'package:analyzer_plugin/starter.dart';

import 'analyzer_plugin.dart';

void startSidecarPlugin(SendPort sendPort, SidecarAnalyzerPlugin plugin) {
  ServerPluginStarter(plugin).start(sendPort);
}
