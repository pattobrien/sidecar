import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:sidecar_cli/sidecar_cli.dart';

import '../exit_codes.dart';

class InitCommand extends Command<int> {
  InitCommand();

  @override
  String get description => 'initialize a project with sidecar configuration';

  @override
  String get name => 'init';

  @override
  FutureOr<int> run() async {
    try {
      final currentDirectory = Directory.current;
      print('project directory: ${currentDirectory.path}');
      final projectService = ProjectService(currentDirectory);

      await projectService.insertPluginIntoProjectPubspec();
      final pluginVersion = await projectService.getPluginVersion();
      await projectService.copyBasePluginFromSource(pluginVersion);
      await projectService.insertProjectPluginIntoPubspec();
      await projectService.setupAnalysisOptionsFile();
      await projectService.insertVscodeTask();
      return ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
