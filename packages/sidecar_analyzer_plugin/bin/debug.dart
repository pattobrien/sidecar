import 'dart:isolate';

import 'package:sidecar_analyzer_plugin/src/analyzer_plugin_starter.dart';

/// Run lints with the debugger
void main(List<String> args) {
  final receivePort = ReceivePort();

  print('main init');
  start(args, receivePort.sendPort);
}
