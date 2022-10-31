import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';

import '../../../services/package_generator.dart';
import '../../../utils/logger/logger.dart';
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
      final cont = ProviderContainer();
      await cont.read(packageGeneratorProvider).generate(Directory.current);
      return ExitCode.success;
    } catch (e, stackTrace) {
      logger.severe('CLI ERROR', e, stackTrace);
      rethrow;
    }
  }
}
