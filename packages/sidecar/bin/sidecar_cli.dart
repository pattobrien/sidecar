import 'dart:io';

import 'package:sidecar/src/client/cli/command_runner.dart';

void main(List<String> arguments) async {
  await flushThenExit(await CliCommandRunner().run(arguments));
}

Future flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}
