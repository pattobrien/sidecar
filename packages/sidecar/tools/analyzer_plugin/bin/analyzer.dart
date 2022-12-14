import 'dart:isolate';

import 'package:sidecar/starters/starters.dart';

import 'constructors.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  await startAnalyzer(args, sendPort, constructors: constructors);
}
