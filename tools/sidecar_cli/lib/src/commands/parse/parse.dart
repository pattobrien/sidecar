import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_cli/sidecar_cli.dart';
import 'package:sidecar_cli/src/configurations/package/lint_declaration.dart';
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

      final projectConfiguration =
          await ProjectUtilities.getSidecarConfiguration(
        Directory.current.uri,
      );
      final lintDeclarations = projectConfiguration.lintPackages ?? {};
      print('number of lint configurations: ${lintDeclarations.length}');
      for (var lintDeclaration in lintDeclarations.values) {
        print(
            'lint package: ${lintDeclaration.packageName} || # of package lints: ${lintDeclaration.lints.length} || first lint: ${lintDeclaration.lints.entries.first.value.lintId}');
      }
      return ExitCode.success;
    } catch (e) {
      print('COMMAND RUNNER ERROR: $e');
      rethrow;
    }
  }
}
