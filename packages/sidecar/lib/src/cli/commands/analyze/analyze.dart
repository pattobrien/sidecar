import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:package_config/package_config_types.dart';
import 'package:path/path.dart' as p;

import '../../../configurations/project/errors.dart';
import '../../project/constants.dart';
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
      final configUri = Uri.file(
          p.join(Directory.current.path, '.dart_tool', 'package_config.json'));
      final contents = File.fromUri(configUri).readAsBytesSync();
      final packageConfig = PackageConfig.parseBytes(contents, configUri);
      final sidecarUri = packageConfig.packages.firstWhere(
          (element) => element.name == 'sidecar_analyzer_plugin_core');
      final sidecarPackageEntrypointPath =
          p.join(sidecarUri.root.path, 'bin', 'debug.dart');
      final process = await Process.start(
        'dart',
        ['run', sidecarPackageEntrypointPath],
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
