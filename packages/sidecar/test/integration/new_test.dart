import 'dart:io';

import 'package:file/memory.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_config/package_config_types.dart';
import 'package:path/path.dart' hide equals;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/analyzer/plugin/active_package_provider.dart';
import 'package:sidecar/src/analyzer/plugin/files_provider.dart';
import 'package:sidecar/src/analyzer/plugin/plugin.dart';
import 'package:sidecar/src/analyzer/plugin/sidecar_analyzer.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/protocol/active_package_root.dart';
import 'package:sidecar/src/protocol/constants/constants.dart';
import 'package:sidecar/src/test/assets/dart_project.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'mock_communication_channel.dart';
import 'string_lint.dart';

Future<void> main() async {
  final constructors = <SidecarBaseConstructor>[AvoidStringLiterals.new];
  final configuration = ProjectConfiguration.fromCodes([
    kAvoidStringLiteralsCode,
  ]);
  await setUpAnalyzer(constructors, configuration);
  group('test lint', () {
    final analyzedFile = AnalyzedFile(
        Uri.parse('/workspace/my_app/lib/main.dart'),
        contextRoot: Uri.parse('/workspace/my_app/'));
    registerFallbackValue(LintNotification(analyzedFile, {}));
    test('test', () async {
      final update = FileUpdateEvent.add(analyzedFile, '// test');
      final request = FileUpdateRequest([update]);
      final analyzer = _container.read(sidecarAnalyzerProvider);
      final stream = _container.read(communicationChannelStreamProvider.stream);
      stream.listen((dynamic event) => print(event.toString()));
      await analyzer.handleUpdateFiles(request);
      final result = verify(
          () => _mockChannel.sendNotification(captureAny<LintNotification>()));
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
  // setUp(() async {
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
  _mockChannel = MockCommunicationChannel();
  // final resourceProvider = OverlayResourceProvider(MemoryResourceProvider());
  final container = ProviderContainer(overrides: [
    communicationChannelProvider.overrideWithValue(_mockChannel),
    ruleConstructorProvider.overrideWithValue(constructors),
    activePackageProvider.overrideWithProvider(packageProvider),
    fileSystemProvider.overrideWithValue(MemoryFileSystem())
    // analyzerResourceProvider.overrideWithValue(resourceProvider),
  ]);
  final fileSystem = container.read(fileSystemProvider);
  final resourceProvider = container.read(analyzerResourceProvider);
  _container = container;

  final project = createDartProject(
    parentDirectoryPath: workspaceUri.path,
    resourceProvider: resourceProvider,
    fileSystem: fileSystem,
    projectName: appName,
    sidecarProjectConfiguration: package.sidecarOptionsFile,
  );

  await _container.read(activePackageProvider.future);
  final analyzer = container.read(sidecarAnalyzerProvider);
  return analyzer.setup();
  // });
}

late ProviderContainer _container;
late MockCommunicationChannel _mockChannel;
