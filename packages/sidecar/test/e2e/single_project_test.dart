import 'package:glob/glob.dart';
import 'package:intl_lints/intl_lints.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;
import 'package:sidecar/src/configurations/sidecar_spec/sidecar_spec.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:sidecar/src/test/utilities/expected_lint.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../helpers/example_file_contents.dart';
import '../helpers/example_lints.dart';
import '../helpers/test_helpers.mocks.dart';
import '../helpers/test_starter.dart';

void main() {
  group('single project lint results:', () {
    final constructors = [AvoidStringLiteral.new];
    final sidecarYaml = SidecarSpec(includes: [
      Glob('lib/**')
    ], lints: {
      exampleRuleCode.package: LintPackageOptions(rules: {
        exampleRuleCode.id: const LintOptions(),
      }),
    });

    late PackageResource app;
    late WorkspaceResource workspace;
    late MockStdoutReporter reporter;

    setUpAll(() async {
      workspace = await createWorkspace(constructors: constructors);
      app = await workspace.createDartPackage(sidecarYaml: sidecarYaml);
      app.deleteLibFolder();
    });

    setUp(() async {
      reporter = MockStdoutReporter();
      app.deleteLibFolder();
    });

    test('1 lint result', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(exampleRuleCode, 28, 14)]);
    });

    test('2 lint results', () async {
      app.modifyFile(kMainFilePath, kContentWithTwoStrings);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [
        lint(exampleRuleCode, 28, 14),
        lint(exampleRuleCode, 59, 21),
      ]);
    });

    test('0 lint results', () async {
      app.modifyFile(kMainFilePath, kContentWithoutString);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;

      // expect(results.length, 1);
      expectLints(results.first, []);
    });

    test('1 quick fix results', () async {
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      final client = await analyzeTestResources(app.root, reporter);
      // print('getting file with path ${mainFile.path}');
      final results = await client.getQuickFixes(mainFile.path, 30);
      expect(results.length, 1);
    });

    test('0 quick fix results', () async {
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      final client = await analyzeTestResources(app.root, reporter);
      final results = await client.getQuickFixes(mainFile.path, 20);
      expect(results.length, 0);
    });

    test('file is updated with error', () async {
      // start with a basic file with no lintable string
      final mainFile = app.modifyFile(kMainFilePath, kContentWithoutString);
      final client = await analyzeTestResources(app.root, reporter);
      final results = verify(reporter.handleLintNotification(captureAny));
      expectLints(results.captured.first, []);
      // update file with a lintable string
      await client.handleFileChange(mainFile.toUri(), ' $kContentWithString');
      final results2 = verify(reporter.handleLintNotification(captureAny));
      expectLints(results2.captured.first, [lint(exampleRuleCode, 29, 14)]);
    });

    test('file is updated with an extra character', () async {
      // start with a basic file with no lintable string
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      final client = await analyzeTestResources(app.root, reporter);
      final results = verify(reporter.handleLintNotification(captureAny));
      expectLints(results.captured.first, [lint(exampleRuleCode, 28, 14)]);
      // update file with a lintable string
      await client.handleFileChange(mainFile.toUri(), ' $kContentWithString');
      final results2 = verify(reporter.handleLintNotification(captureAny));
      expectLints(results2.captured.first, [lint(exampleRuleCode, 29, 14)]);
    });

    test('file is updated with a line break', () async {
      // start with a basic file with no lintable string
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      final client = await analyzeTestResources(app.root, reporter);
      final results = verify(reporter.handleLintNotification(captureAny));
      expectLints(results.captured.first, [lint(exampleRuleCode, 28, 14)]);
      // update file with a lintable string
      await client.handleFileChange(mainFile.toUri(), '\n$kContentWithString');
      final results2 = verify(reporter.handleLintNotification(captureAny));
      expectLints(results2.captured.first, [lint(exampleRuleCode, 29, 14)]);
    });

    // test('new file is added', () async {
    //   // start with a basic file with no lintable string
    //   // final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
    //   final client = await analyzeTestResources(app.root, reporter);
    //   // update file with a lintable string
    //   final mainFile =
    //       app.modifyFile(p.join('lib', 'random.dart'), kContentWithString);
    //   await client.handleFileChange(mainFile.toUri(), kContentWithString);
    //   final results2 = verify(reporter.handleLintNotification(captureAny));
    //   expectLints(results2.captured.first, [lint(exampleRuleCode, 28, 14)]);
    // });
  });
}
