import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:sidecar_cli/sidecar_cli.dart';
import 'package:sidecar_cli/src/utilities/plugin_pubspec_parse_utils.dart';

import '../exit_codes.dart';

class PublishCommand extends Command<int> {
  PublishCommand();

  @override
  String get description => 'publish a sidecar plugin';

  @override
  String get name => 'publish';

  @override
  FutureOr<int> run() async {
    try {
      final projectService = ProjectService(Directory.current);

      print('project directory: ${Directory.current}');

      final lintDeclarations =
          await PluginPubspecParseUtils.getLintDeclarations(
        Directory.current.uri,
      );
      print('number of lint declarations: ${lintDeclarations.length}');
      lintDeclarations.forEach((element) {
        print('${element.id} || ${element.className} || ${element.import}');
      });
      // final edits =
      //     await ConfigParseUtilities.parseEditConfig(Directory.current.uri);
      // await projectService.clearPreviousLints();
      // await projectService.importLints(lints);
      // await projectService.importEdits(edits);
      // await projectService.generateLintBootstrapFunction(lints);
      // await projectService.generateCodeEditBootstrapFunction(edits);
      // await projectService.restartAnalyzerPlugin();

      return ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
