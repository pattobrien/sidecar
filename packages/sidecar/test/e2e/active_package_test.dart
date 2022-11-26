import 'package:mockito/mockito.dart';
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

@Tags(['e2e'])
@Timeout(Duration(minutes: 15))
void main() {
  group('active package test - analysis_options.yaml', () {
    final constructors = [StringLiterals.new];
    final sidecarYaml = SidecarSpec(lints: {
      kStringLiteralsCode.package: LintPackageOptions(rules: {
        kStringLiteralsCode.code: const LintOptions(
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
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithSidecar);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(kStringLiteralsCode, 28, 14)]);
    });

    test('sidecar plugin is not enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithoutSidecar);
      await analyzeTestResources(app.root, reporter);

      verifyNever(reporter.handleLintNotification(captureAny));
    });
  });

  group('active package - sidecar.yaml:', () {
    final constructors = [StringLiterals.new];
    final sidecarYaml = SidecarSpec(lints: {
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

    setUp(() {
      reporter = MockStdoutReporter();
    });

    test('sidecar plugin is enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithSidecar);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(kStringLiteralsCode, 28, 14)]);
    });

    test('sidecar plugin is not enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithoutSidecar);
      await analyzeTestResources(app.root, reporter);

      verifyNever(reporter.handleLintNotification(captureAny));
    });
  });
}
