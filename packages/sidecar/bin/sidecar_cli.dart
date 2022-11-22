import 'dart:io';

import 'package:sidecar/src/cli/command_runner.dart';

void main(List<String> arguments) async {
  await flushThenExit(await PlatformCommandRunner().run(arguments));
}

Future flushThenExit(int status) {
  return Future.wait<void>([
    stdout.close(),
    stderr.close(),
  ]).then<void>(
    (_) => exit(status),
  );
}
