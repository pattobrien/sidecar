import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:sidecar/sidecar.dart';

import '../exit_codes.dart';

class AnalyzeCommand extends Command<int> {
  AnalyzeCommand();

  @override
  String get description => 'analyze';

  @override
  String get name => 'analyze';

  @override
  FutureOr<int> run() async {
    try {
      // stdout.encoding = AsciiCodec(allowInvalid: false);
      // stdout.writeln('ansi: ${stdout.supportsAnsiEscapes}');
      // print('project directory: ${Directory.current}');
      final process = await Process.start(
        'dart',
        ['run', '.sidecar/sidecar_analyzer_plugin/bin/debug.dart'],
        workingDirectory: Directory.current.path,
      );
      process.stdout.listen((e) => stdout.writeln(utf8.decode(e)));
      process.stderr.listen((e) => stdout.writeln(utf8.decode(e)));
      stdout.writeln((await process.exitCode).toString());
      return ExitCode.success;
    } on MissingSidecarConfiguration catch (e) {
      // print(e.toString());
      rethrow;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
