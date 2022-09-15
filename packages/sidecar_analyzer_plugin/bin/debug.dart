import 'dart:isolate';

import 'package:sidecar_analyzer_plugin/src/analyzer_plugin_starter.dart';
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

/// Run lints with the debugger
void main(List<String> args) async {
  final reloader = await HotReloader.create();
  final receivePort = ReceivePort();
  final newArgs = [...args, '--debug'];
  start(newArgs, receivePort.sendPort);
  reloader.stop();
}
