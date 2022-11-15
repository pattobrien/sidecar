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
    if (!stdout.supportsAnsiEscapes) stdout.writeln('ansi is not supported!');

    final newArgs = [...?argResults?.arguments];
    final isDebug = newArgs.any((flag) => flag == '--debug' || flag == 'debug');

    if (!isDebug) newArgs.add('--cli');
    if (isDebug) newArgs.add('--enable-vm-service');

    final receivePort = ReceivePort();
    receivePort.listen(
      (dynamic message) => stdout.write(message),
      onDone: () {},
    );
    await startSidecarCli(receivePort.sendPort, ['--cli']);
    return ExitCode.success;
  }
}
