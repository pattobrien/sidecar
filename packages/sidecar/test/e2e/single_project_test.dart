import 'package:intl_lints/intl_lints.dart';
import 'package:mockito/mockito.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../helpers/example_file_contents.dart';
import '../helpers/expected_lint.dart';
import '../helpers/test_helpers.mocks.dart';
import '../helpers/test_starter.dart';

@Tags(['e2e'])
void main() {
  group('single project lint results:', () {
    final constructors = [StringLiterals.new];
    final sidecarYaml = ProjectConfiguration.fromCodes([kStringLiteralsCode]);

    late PackageResource app;
    late WorkspaceResource workspace;
    late MockStdoutReporter reporter;

    setUpAll(() async {
      workspace = await createWorkspace(constructors: constructors);
      app = await workspace.createDartPackage(sidecarYaml: sidecarYaml);
    });

    setUp(() async {
      reporter = MockStdoutReporter();
    });

    test('1 lint result', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(kStringLiteralsCode, 28, 14)]);
    });

    test('2 lint results', () async {
      app.modifyFile(kMainFilePath, kContentWithTwoStrings);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [
        lint(kStringLiteralsCode, 28, 14),
        lint(kStringLiteralsCode, 59, 21),
      ]);
    });

    test('0 lint results', () async {
      app.modifyFile(kMainFilePath, kContentWithoutString);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expect(results.length, 1);
      expectLints(results.first, []);
    });
  });
}
