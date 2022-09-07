import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:sidecar_cli/sidecar_cli.dart';

import '../exit_codes.dart';

class RebuildCommand extends Command<int> {
  RebuildCommand();

  @override
  String get description =>
      'rebuild sidecar plugin based on current project\'s configuration file';

  @override
  String get name => 'rebuild';

  @override
  FutureOr<int> run() async {
    try {
      final projectService = ProjectService(Directory.current);

      print('project directory: ${Directory.current}');

      final lints =
          await ConfigParseUtilities.parseLintConfig(Directory.current.uri);
      final edits =
          await ConfigParseUtilities.parseEditConfig(Directory.current.uri);
      // await projectService.clearPreviousLints();
      await projectService.importLints(lints);
      await projectService.generateLintBootstrapFunction(lints);
      await projectService.generateCodeEditBootstrapFunction(edits);
      await projectService.restartAnalyzerPlugin();

      return ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
