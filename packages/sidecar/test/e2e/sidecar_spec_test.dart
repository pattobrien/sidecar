import 'package:glob/glob.dart';
import 'package:intl_lints/intl_lints.dart';
import 'package:mockito/mockito.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/sidecar_spec/sidecar_spec.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:sidecar/src/test/utilities/expected_lint.dart';
import 'package:test/scaffolding.dart';

import '../helpers/example_file_contents.dart';
import '../helpers/example_lints.dart';
import '../helpers/test_helpers.mocks.dart';
import '../helpers/test_starter.dart';

void main() {
  group('SidecarSpec configured severity:', () {
    final constructors = [AvoidStringLiteral.new];

    late PackageResource app;
    late WorkspaceResource workspace;
    late MockStdoutReporter reporter;

    setUpAll(() async {
      workspace = await createWorkspace(constructors: constructors);
      app = await workspace.createDartPackage();
    });

    setUp(() async {
      reporter = MockStdoutReporter();
    });

    test('default severity', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      final sidecarYamlError = SidecarSpec(includes: [
        Glob('lib/**')
      ], lints: {
        exampleRuleCode.package: LintPackageOptions(rules: {
          exampleRuleCode.id: const LintOptions(),
        }),
      });
      app.modifySidecarYaml(sidecarYamlError);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [
        lint(exampleRuleCode, 28, 14, severity: exampleRule.defaultSeverity),
      ]);
    });

    test('info-level severity', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      final sidecarYamlError = SidecarSpec(includes: [
        Glob('lib/**')
      ], lints: {
        exampleRuleCode.package: LintPackageOptions(rules: {
          exampleRuleCode.id: const LintOptions(
            severity: LintSeverity.info,
          ),
        }),
      });
      app.modifySidecarYaml(sidecarYamlError);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [
        lint(exampleRuleCode, 28, 14, severity: LintSeverity.info),
      ]);
    });

    test('warning-level severity', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      final sidecarYamlError = SidecarSpec(includes: [
        Glob('lib/**')
      ], lints: {
        exampleRuleCode.package: LintPackageOptions(rules: {
          exampleRuleCode.id: const LintOptions(
            severity: LintSeverity.warning,
          ),
        }),
      });
      app.modifySidecarYaml(sidecarYamlError);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [
        lint(exampleRuleCode, 28, 14, severity: LintSeverity.warning),
      ]);
    });

    test('error-level severity', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      final sidecarYamlError = SidecarSpec(includes: [
        Glob('lib/**')
      ], lints: {
        exampleRuleCode.package: LintPackageOptions(rules: {
          exampleRuleCode.id: const LintOptions(
            severity: LintSeverity.error,
          ),
        }),
      });
      app.modifySidecarYaml(sidecarYamlError);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [
        lint(exampleRuleCode, 28, 14, severity: LintSeverity.error),
      ]);
    });
  });
}
