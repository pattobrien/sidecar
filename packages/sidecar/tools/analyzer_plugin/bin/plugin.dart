import 'dart:isolate';

import 'package:sidecar/sidecar.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  await startSidecarPlugin(sendPort, args);
}
