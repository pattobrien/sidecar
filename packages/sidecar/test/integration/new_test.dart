import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:path/path.dart' hide equals;
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../helpers/string_lint.dart';
import '../helpers/test_helpers.mocks.dart';

Future<void> main() async {
  final reporter = MockStdoutReport();
  final constructors = [AvoidStringLiterals.new];
  final config = ProjectConfiguration.fromCodes([kAvoidStringLiteralsCode]);
  group('single project', () {
    late PackageResource app;
    late WorkspaceResource workspace;
    final root = Directory.systemTemp.uri.resolve(join('workspace'));
    setUp(() async {
      print('creating directory in: ${root.path}');
      workspace = await createWorkspace(
          constructors: constructors, rootPath: root.path);
      app = await workspace.createDartPackage('my_app', sidecarYaml: config);
    });

    test('single lint result', () async {
      await startTestCli(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expect(results.length, 1);
      expectLint(results.first, kAvoidStringLiteralsCode);
    });
  });
}

void expectLint(dynamic actual, RuleCode code) {
  expect(
      actual,
      isA<LintNotification>()
        ..having((p0) => p0.lints.length, 'has one result', 1)
        ..having((p0) => p0.lints.first.rule.code, 'matches code', code)
      // ..having((p0) => p0.lints.first.rule.code, 'matches code', code)
      // ..having((p0) => p0.lints.first.rule.code, 'matches code', code)
      );
}
