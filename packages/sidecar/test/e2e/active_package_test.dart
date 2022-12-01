import 'package:glob/glob.dart';
import 'package:intl_lints/intl_lints.dart';
import 'package:mockito/mockito.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/sidecar_spec/package_options.dart';
import 'package:sidecar/src/configurations/sidecar_spec/rule_options.dart';
import 'package:sidecar/src/configurations/sidecar_spec/sidecar_spec_base.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:sidecar/src/utils/utils.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import '../helpers/example_file_contents.dart';
import '../helpers/example_lints.dart';
import '../helpers/expected_lint.dart';
import '../helpers/test_helpers.mocks.dart';
import '../helpers/test_starter.dart';

void main() {
  group('active package test - analysis_options.yaml', () {
    final constructors = [HardcodedTextString.new];
    final sidecarYaml = SidecarSpec(includes: [
      Glob('lib/**')
    ], lints: {
      intlStringRuleCode.package: LintPackageOptions(rules: {
        intlStringRuleCode.id: const LintOptions(
          enabled: true,
        ),
      }),
    });

    late PackageResource app;
    late WorkspaceResource workspace;
    late MockStdoutReporter reporter;

    setUpAll(() async {
      workspace = await createWorkspace(constructors: constructors);
      app = await workspace.createDartPackage(sidecarYaml: sidecarYaml);
    });

    setUp(() {
      reporter = MockStdoutReporter();
    });

    test('sidecar plugin is enabled', () async {
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithSidecar);
      final client = await analyzeTestResources(app.root, reporter);

      await client.handleFileChange(mainFile.toUri(), kContentWithString);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results[1], [lint(intlStringRuleCode, 28, 14)]);
    });

    test('sidecar plugin is not enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithoutSidecar);
      await analyzeTestResources(app.root, reporter);

      verifyNever(reporter.handleLintNotification(captureAny));
    });
  });

  group('active package - sidecar.yaml:', () {
    final constructors = [HardcodedTextString.new];
    final sidecarYaml = SidecarSpec(includes: [
      Glob('lib/**')
    ], lints: {
      intlStringRuleCode.package: LintPackageOptions(rules: {
        intlStringRuleCode.id: const LintOptions(),
      }),
    });

    late PackageResource app;
    late WorkspaceResource workspace;
    late MockStdoutReporter reporter;

    setUpAll(() async {
      workspace = await createWorkspace(constructors: constructors);
      app = await workspace.createDartPackage(sidecarYaml: sidecarYaml);
    });

    setUp(() {
      reporter = MockStdoutReporter();
    });

    test('sidecar plugin is enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithSidecar);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(intlStringRuleCode, 28, 14)]);
    });

    test('sidecar plugin is not enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithoutSidecar);
      await analyzeTestResources(app.root, reporter);

      verifyNever(reporter.handleLintNotification(captureAny));
    });
  });
}
