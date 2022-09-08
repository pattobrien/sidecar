import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_cli/sidecar_cli.dart';
import 'package:sidecar_cli/src/configurations/plugin/lint_declaration.dart';
import 'package:sidecar_cli/src/utilities/package_parse_utils.dart';

import '../exit_codes.dart';

class ParseCommand extends Command<int> {
  ParseCommand();

  @override
  String get description => 'parse';

  @override
  String get name => 'parse';

  @override
  FutureOr<int> run() async {
    try {
      print('project directory: ${Directory.current}');

      final declarations = await ConfigParseUtilities.parseLintConfig(
        Directory.current.uri,
      );
      final lintDeclarations = declarations;
      print('number of lint configurations: ${lintDeclarations.length}');
      for (var lintDeclaration in lintDeclarations) {
        print(
            'lint id: ${lintDeclaration.id} || lint className (from ext.): ${lintDeclaration.className} || lint config: ${lintDeclaration.configuration}');
      }
      return ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
