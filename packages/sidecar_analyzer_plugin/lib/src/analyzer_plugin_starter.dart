import 'dart:isolate';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/starter.dart';
import 'package:riverpod/riverpod.dart';

import 'analyzer_plugin.dart';
import 'utils/utils.dart';

void start(List<String> args, SendPort sendPort) async {
  final ref = ProviderContainer();
  final resourceProvider = PhysicalResourceProvider.INSTANCE;
  final plugin = WorkspacePlugin(resourceProvider: resourceProvider, ref: ref);

  ServerPluginStarter(plugin).start(sendPort);

  // Logger.logLine('START PLUGIN');
}
