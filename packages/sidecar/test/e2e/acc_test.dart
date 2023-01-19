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
  group('acc - debugging', () {
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
      workspace = createWorkspace(constructors: constructors);
      app = workspace.createDartPackage(sidecarYaml: sidecarYaml);
      await runPubGet(app.projectFolder.toUri());
    });

    setUp(() {
      reporter = MockStdoutReporter();
    });

    tearDown(() {
      app.deleteLibFolder();
    });

    test('1 lint result', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(exampleRuleCode, 28, 14)]);
    });

    test('0 lint results', () async {
      app.modifyFile(kMainFilePath, kContentWithoutString);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;

      // expect(results.length, 1);
      expectLints(results.first, []);
    });
  });
}
