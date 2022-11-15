import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:args/command_runner.dart';

import '../../../analyzer/starters/starters.dart';
import '../exit_codes.dart';

class AnalyzeCommand extends Command<int> {
  AnalyzeCommand() {
    argParser.addFlag('verbose', abbr: 'v');
    argParser.addFlag('debug', abbr: 'd');
  }

  @override
  String get description => 'analyze';

  @override
  String get name => 'analyze';

  @override
  FutureOr<int> run() async {
    final args = [...?argResults?.arguments];
    final isDebug = args.any((flag) => flag == '--debug' || flag == 'debug');

    if (!isDebug) args.add('--cli');
    //TODO: how can we run vm using  ```sidecar analyze```
    if (isDebug) args.add('--enable-vm-service');

    final receivePort = ReceivePort();
    receivePort.listen((dynamic message) => stdout.write(message));
    await startSidecarCli(receivePort.sendPort, ['--cli']);
    return ExitCode.success;
  }
}
