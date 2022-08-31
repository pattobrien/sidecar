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
      //
      final cacheDirectory = SidecarPubServiceImpl().cacheDirectory;
      final currentDirectory = Directory.current;
      final projectService =
          ProjectService(currentDirectory, cacheDirectory: cacheDirectory);

      print('project directory: ${currentDirectory.path}');

      final lints =
          await ConfigParseUtilities.parseConfig(currentDirectory.uri);

      await projectService.importLints(lints);
      await projectService.generateLintBootstrapFunction(lints);
      await projectService.restartAnalyzerPlugin();

      return ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
