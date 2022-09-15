import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:sidecar_cli/src/commands/init/init.dart';
import 'package:sidecar_cli/src/commands/parse/parse.dart';
import 'package:sidecar_cli/src/commands/publish/publish.dart';
import 'package:sidecar_cli/src/commands/rebuild/rebuild.dart';

import 'exit_codes.dart';
import '../utilities/logger.dart';

const kExecutableName = 'Sidecar CLI';
const kExecutableDescription = '\n\n';

class PlatformCommandRunner extends CommandRunner<int> {
  PlatformCommandRunner() : super(kExecutableName, kExecutableDescription) {
    // All CLI commands are listed below
    addCommand(InitCommand());
    addCommand(RebuildCommand());
    addCommand(PublishCommand());
    addCommand(ParseCommand());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final verbose = args.contains('-v');
      logger = verbose ? Logger.verbose() : Logger.standard();
      return await runCommand(parse(args)) ?? ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
