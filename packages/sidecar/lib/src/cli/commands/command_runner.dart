import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';

import '../utilities/logger.dart';
import 'analyze/analyze.dart';
import 'exit_codes.dart';

const kExecutableName = 'Sidecar CLI';

const kExecutableDescription = '\n\n';

class PlatformCommandRunner extends CommandRunner<int> {
  PlatformCommandRunner() : super(kExecutableName, kExecutableDescription) {
    // All CLI commands are listed below
    addCommand(AnalyzeCommand());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      // final verbose = args.contains('-v');
      // verbose
      //     ? print('running cli in verbose mode')
      //     : print('running cli in normal mode');

      // logger = verbose ? Logger.verbose() : Logger.standard();
      return await runCommand(parse(args)) ?? ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
