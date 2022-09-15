import 'dart:isolate';

import 'package:sidecar_analyzer_plugin/sidecar_analyzer_plugin.dart';

void main(List<String> args, SendPort sendPort) {
  args.add('--instrumentation-log-file=sidecar_logs.txt');

  start(args, sendPort);
}
