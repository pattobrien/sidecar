import 'package:glob/glob.dart';
import 'package:intl_lints/intl_lints.dart';
import 'package:mockito/mockito.dart';
import 'package:sidecar/src/configurations/sidecar_spec/sidecar_spec.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../helpers/example_file_contents.dart';
import '../helpers/expected_lint.dart';
import '../helpers/test_helpers.mocks.dart';
import '../helpers/test_starter.dart';

@Tags(['e2e'])
@Timeout(Duration(minutes: 15))
void main() {
  group('single project lint results:', () {
    final constructors = [StringLiterals.new];
    final sidecarYaml = SidecarSpec(includes: [
      Glob('lib/**')
    ], lints: {
      kStringLiteralsCode.package: LintPackageOptions(rules: {
        kStringLiteralsCode.code: const LintOptions(),
      }),
    });

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

    test('1 quick assist results', () async {
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      final client = await analyzeTestResources(app.root, reporter);
      final results = await client.getQuickFixes(mainFile.toUri(), 30);
      expect(results.length, 1);
    });

    test('0 quick assist results', () async {
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      final client = await analyzeTestResources(app.root, reporter);
      final results = await client.getQuickFixes(mainFile.toUri(), 20);
      expect(results.length, 0);
    });

    test('0 quick assist results', () async {
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      final client = await analyzeTestResources(app.root, reporter);
      final results = await client.getQuickFixes(mainFile.toUri(), 20);
      expect(results.length, 0);
    });
  });
}
