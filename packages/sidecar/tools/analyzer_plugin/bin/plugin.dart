import 'dart:isolate';

import 'package:sidecar/sidecar.dart';

import 'constructors.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  // args.add('--instrumentation-log-file=sidecar_logs.txt');

  await startSidecarPlugin(sendPort, args,
      constructors: constructors, isMiddleman: true);
}
