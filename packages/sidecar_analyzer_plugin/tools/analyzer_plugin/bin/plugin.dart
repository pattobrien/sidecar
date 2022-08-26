import 'dart:isolate';

import 'package:sidecar_analyzer_plugin/src/analyzer_plugin_starter.dart';

void main(List<String> args, SendPort sendPort) {
  args.add('--instrumentation-log-file=sidecar_logs.txt');
  start(args, sendPort);
}
