import 'dart:isolate';

import 'package:sidecar/sidecar.dart';

import 'constructors.dart';

Future<void> main(List<String> args) async {
  final receivePort = ReceivePort();
  await startSidecarCli(receivePort.sendPort, args, constructors: constructors);
}
