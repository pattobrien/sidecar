import 'dart:isolate';

import 'package:sidecar/sidecar.dart';

import 'constructors.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  await startSidecarPlugin(sendPort, args,
      constructors: constructors, isMiddleman: false, isPlugin: true);
}
