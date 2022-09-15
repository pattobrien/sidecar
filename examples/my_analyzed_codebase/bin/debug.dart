import 'dart:isolate';

import 'package:sidecar_analyzer_plugin/sidecar_analyzer_plugin.dart';

/// Run lints with the debugger
void main(List<String> args) {
  final receivePort = ReceivePort();
  final newArgs = [...args, '--debug'];
  start(newArgs, receivePort.sendPort);
}
