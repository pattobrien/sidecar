import 'package:glob/glob.dart';
import 'package:intl_lints/intl_lints.dart';
import 'package:mockito/mockito.dart';
import 'package:sidecar/src/configurations/sidecar_spec/package_options.dart';
import 'package:sidecar/src/configurations/sidecar_spec/rule_options.dart';
import 'package:sidecar/src/configurations/sidecar_spec/sidecar_spec_base.dart';
import 'package:sidecar/src/utils/utils.dart';
import 'package:sidecar_test/sidecar_test.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import '../helpers/example_file_contents.dart';
import '../helpers/example_lints.dart';
import '../helpers/test_helpers.mocks.dart';
import '../helpers/test_starter.dart';

void main() {
  group('active package test - analysis_options.yaml', () {
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

    test('sidecar plugin is enabled', () async {
      final mainFile = app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithSidecar);
      final client = await analyzeTestResources(app.root, reporter);

      await client.handleFileChange(mainFile.toUri(), kContentWithString);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.single, [lint(exampleRuleCode, 28, 14)]);
    });
  });
  group('active package - sidecar.yaml:', () {
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

    test('sidecar plugin is enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithSidecar);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(exampleRuleCode, 28, 14)]);
    });
  });
}
