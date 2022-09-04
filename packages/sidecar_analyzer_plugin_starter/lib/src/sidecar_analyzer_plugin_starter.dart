import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import 'package:sidecar/sidecar.dart';
import 'package:sidecar_analyzer_plugin/sidecar_analyzer_plugin.dart' as plugin;

import 'plugin_bootstrapper.dart';
import 'plugin_code_fix_bootstrapper.dart';

void start(List<String> args, SendPort sendPort) async {
  final ref = ProviderContainer();
  final nodeRegistry = NodeLintRegistry();

  final lints = pluginBootstrapper(nodeRegistry, ref);
  final edits = pluginCodeFixBootstrapper(ref);

  plugin.start(args, sendPort, lints, edits, nodeRegistry, ref);
}
