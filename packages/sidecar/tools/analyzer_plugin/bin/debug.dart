import 'dart:isolate';

import 'package:sidecar/starters/starters.dart';

Future<void> main(List<String> args) async {
  final receivePort = ReceivePort();
  await startSidecarCli(receivePort.sendPort, args);
}
