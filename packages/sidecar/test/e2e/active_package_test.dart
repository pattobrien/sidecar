import 'package:mockito/mockito.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/protocol/exceptions/active_project_exceptions.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:intl_lints/intl_lints.dart';
import 'package:test/test.dart';

import '../helpers/example_file_contents.dart';
import '../helpers/expected_lint.dart';
import '../helpers/test_helpers.mocks.dart';
import '../helpers/test_starter.dart';

void main() {
  group('active package test - analysis_options.yaml', () {
    final constructors = [StringLiterals.new];
    final sidecarYaml = ProjectConfiguration.fromCodes([kStringLiteralsCode]);

    late PackageResource app;
    late WorkspaceResource workspace;
    late MockStdoutReport reporter;

    setUpAll(() async {
      workspace = await createWorkspace(constructors: constructors);
      app = await workspace.createDartPackage(sidecarYaml: sidecarYaml);
    });

    setUp(() async {
      reporter = MockStdoutReport();
    });

    test('sidecar is enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithSidecar);
      await analyzeTestResources(app.root, reporter);
      final results =
          verify(reporter.handleLintNotification(captureAny)).captured;
      expectLints(results.first, [lint(kStringLiteralsCode, 28, 14)]);
    });

    //TODO: this is correctly throwing an error: how do we handle it though?
    test('sidecar is not enabled', () async {
      app.modifyFile(kMainFilePath, kContentWithString);
      app.modifyFile(kAnalysisOptionsYaml, kAnalysisYamlContentWithoutSidecar);

      expect(analyzeTestResources(app.root, reporter),
          throwsA(isA<SidecarAnalyzerException>()));
    });
  });
}
