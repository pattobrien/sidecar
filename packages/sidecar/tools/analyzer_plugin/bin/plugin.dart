import 'dart:isolate';

import 'package:sidecar/starters/starters.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  await startSidecarPlugin(sendPort, args);
}
