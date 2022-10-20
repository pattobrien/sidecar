import 'package:args/command_runner.dart';

import 'analyze/analyze.dart';
import 'exit_codes.dart';
import 'generate/generate.dart';

const kExecutableName = 'Sidecar CLI';

const kExecutableDescription = '\n\n';

class PlatformCommandRunner extends CommandRunner<int> {
  PlatformCommandRunner() : super(kExecutableName, kExecutableDescription) {
    // All CLI commands are listed below
    addCommand(AnalyzeCommand());
    addCommand(GenerateCommand());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      return await runCommand(parse(args)) ?? ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
