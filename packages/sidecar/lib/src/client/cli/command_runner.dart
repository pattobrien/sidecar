import 'package:args/command_runner.dart';

import '../../protocol/constants/constants.dart';
import '../../utils/logger/logger.dart';
import 'commands.dart';
import 'exit_codes.dart';

class CliCommandRunner extends CommandRunner<int> {
  CliCommandRunner() : super(kSidecarCliName, kSidecarCliDescription) {
    addCommand(AnalyzeCommand());
    addCommand(GenerateCommand());
    addCommand(InitCommand());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      return await runCommand(parse(args)) ?? ExitCode.success;
    } catch (e, stackTrace) {
      // logger.severe('COMMAND RUNNER ERROR', e, stackTrace);
      rethrow;
    }
  }
}
