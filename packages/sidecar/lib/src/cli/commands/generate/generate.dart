import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../services/package_generator.dart';
import '../exit_codes.dart';

class GenerateCommand extends Command<int> {
  GenerateCommand();

  @override
  String get description => 'generate';

  @override
  String get name => 'generate';

  @override
  FutureOr<int> run() async {
    try {
      final generator = PackageGenerator();
      await generator.generate(Directory.current);
      return ExitCode.success;
    } catch (e) {
      stdout.writeln('CLI ERROR: $e');
      rethrow;
    }
  }
}
