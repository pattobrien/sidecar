import 'package:args/command_runner.dart';
import 'package:sidecar_cli/src/commands/init/init.dart';
import 'package:sidecar_cli/src/commands/publish/publish.dart';
import 'package:sidecar_cli/src/commands/rebuild/rebuild.dart';

import 'exit_codes.dart';

const kExecutableName = 'Sidecar CLI';
const kExecutableDescription = '\n\n';

class PlatformCommandRunner extends CommandRunner<int> {
  PlatformCommandRunner() : super(kExecutableName, kExecutableDescription) {
    // All CLI commands are listed below
    addCommand(InitCommand());
    addCommand(RebuildCommand());
    addCommand(PublishCommand());
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
