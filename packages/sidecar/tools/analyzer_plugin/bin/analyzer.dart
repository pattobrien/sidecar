import 'dart:isolate';

import 'package:sidecar/sidecar.dart';

import 'constructors.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  await analyzerStarter(args, sendPort, constructors: constructors);
}
