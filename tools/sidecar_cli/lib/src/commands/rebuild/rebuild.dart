import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../sidecar_cli.dart';
import '../exit_codes.dart';

class RebuildCommand extends Command<int> {
  RebuildCommand();

  @override
  String get description =>
      "rebuild sidecar plugin based on current project's configuration file";

  @override
  String get name => 'rebuild';

  @override
  FutureOr<int> run() async {
    try {
      await rebuildProcess();
      return ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}

Future<void> rebuildProcess() async {
  final projectService = ProjectService(Directory.current);

  print('project directory: ${Directory.current}');

  final projectConfiguration =
      await ProjectUtilities.getSidecarConfiguration(Directory.current.uri);

  final lints = projectConfiguration.lintPackages?.values.toList() ?? [];
  final edits = projectConfiguration.assistPackages?.values.toList() ?? [];

  await projectService.clearPreviousLints(lints, edits);
  await projectService.importLintsAndEdits(lints, edits);
  await projectService.generateLintBootstrapFunction(lints);
  await projectService.generateCodeEditBootstrapFunction(edits);
  await projectService.restartAnalyzerPlugin();
}
