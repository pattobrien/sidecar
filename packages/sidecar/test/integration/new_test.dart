import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:package_config/package_config_types.dart';
import 'package:path/path.dart' hide equals;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/analyzer/plugin/active_package_provider.dart';
import 'package:sidecar/src/analyzer/plugin/plugin.dart';
import 'package:sidecar/src/analyzer/plugin/sidecar_analyzer.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/protocol/active_package_root.dart';
import 'package:sidecar/src/protocol/constants/constants.dart';
import 'package:sidecar/src/test/resources/package_resource.dart';
import 'package:sidecar/src/test/resources/workspace_resource.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'string_lint.dart';

Future<void> main() async {
  final constructors = [AvoidStringLiterals.new];
  final config = ProjectConfiguration.fromCodes([
    kAvoidStringLiteralsCode,
  ]);
  await setUpAnalyzer(constructors, config);
  group('test lint', () {
    late PackageResource app;
    late WorkspaceResource workspace;
    setUp(() async {
      workspace = await createWorkspace(constructors: constructors);
      workspace.lintStream.listen((e) => print('event: ${e.toString()}'));
      app = await workspace.createDartPackage('my_app', sidecarYaml: config);
    });
    final analyzedFile = AnalyzedFile(
        Uri.parse('/workspace/my_app/lib/main.dart'),
        contextRoot: Uri.parse('/workspace/my_app/'));
    registerFallbackValue(LintNotification(analyzedFile, {}));
    test('test', () async {
      // final update = FileUpdateEvent.add(analyzedFile, '// test');
      // final request = FileUpdateRequest([update]);

      // await analyzer.handleUpdateFiles(request);
      final result = verify(
          () => mockChannel.sendNotification(captureAny<LintNotification>()));
      // final notifications = result.captured;
      // print(x.callCount);
      expect(result.captured.length, 1);
      // expectLint(notifications[0], 28, 14, kAvoidStringLiteralsCode);
      // expect(captured, matcher);
      // print(captured.toString());
      // expect(response, matcher);
    });
  });
}

// void expectLint(dynamic actual, int offset, int length, RuleCode code) {
//   expect(actual, [
//     isA<SidecarNotification>()
//       ..having((p0) => p0.lints.first.rule.code, 'matches code', code),
//   ]);
// }

Future<void> setUpAnalyzer(
  List<SidecarBaseConstructor> constructors,
  ProjectConfiguration configuration,
) async {
  final directory = Directory.current;
  final workspaceUri = Uri.parse('/workspace/');
  const appName = 'my_app';
  final appRoot =
      ActivePackageRoot(Uri.parse(join(workspaceUri.path, appName)));

  final package = ActivePackage(
    packageRoot: appRoot,
    sidecarPluginPackage: Package(kSidecarPluginName, directory.uri),
    sidecarOptionsFile: configuration,
    workspaceScope: [appRoot.root],
  );

  final packageProvider = FutureProvider((ref) => Future.value(package));

  // final analyzer = container.read(sidecarAnalyzerProvider);
  // return analyzer.setup();
  // });
}
