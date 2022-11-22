import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';

import '../../services/active_project_service.dart';
import '../exit_codes.dart';

class InitCommand extends Command<int> {
  InitCommand();

  @override
  String get description => 'init';

  @override
  String get name => 'init';

  @override
  FutureOr<int> run() async {
    try {
      final ref = ProviderContainer();
      final projectService = ref.read(activeProjectServiceProvider);
      await projectService.createDefaultSidecarYaml(Directory.current.uri);
      return ExitCode.success;
    } catch (e) {
      stdout.writeln('CLI ERROR: $e');
      rethrow;
    }
  }
}
