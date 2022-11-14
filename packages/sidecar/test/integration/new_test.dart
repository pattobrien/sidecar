import 'dart:io';

import 'package:file/memory.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_config/package_config_types.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/analyzer/plugin/active_package_provider.dart';
import 'package:sidecar/src/analyzer/plugin/files_provider.dart';
import 'package:sidecar/src/analyzer/plugin/plugin.dart';
import 'package:sidecar/src/analyzer/plugin/sidecar_analyzer.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/protocol/active_package_root.dart';
import 'package:sidecar/src/protocol/constants/constants.dart';
import 'package:sidecar/src/test/assets/project_creator.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'mock_communication_channel.dart';
import 'string_lint.dart';

Future<void> main() async {
  final constructors = <SidecarBaseConstructor>[AvoidStringLiterals.new];
  final rules = constructors.map((e) => e());
  final configuration = ProjectConfiguration(
    lintPackages: {
      kPackage: LintPackageConfiguration(
        //
        lints: {
          for (final code in rules.map((e) => e.code)) code.code: null,
        },
      )
    },
  );
  await setUpAnalyzer(constructors, configuration);
  group('test lint', () {
    final analyzedFile = AnalyzedFile(
        Uri.parse('/workspace/my_app/lib/main.dart'),
        contextRoot: Uri.parse('/workspace/my_app/'));
    registerFallbackValue(SidecarNotification.lint(analyzedFile, {}));
    registerFallbackValue(SidecarNotification.lint(analyzedFile, {}));
    test('test', () async {
      final update = FileUpdateEvent.add(analyzedFile, '// test');
      final request = FileUpdateRequest([update]);
      final analyzer = _container.read(sidecarAnalyzerProvider);
      final stream =
          _container.read(communitcationChannelStreamProvider.stream);
      stream.listen((dynamic event) {
        print(event.toString());
      });
      final response = await analyzer.handleUpdateFiles(request);
      final x = verify(() => _mockChannel.sendNotification(captureAny()));

      print(x.callCount);
      print(x.captured);
      expect(x.captured.length, 1);
      // expect(captured, matcher);
      // print(captured.toString());
      // expect(response, matcher);
    });
  });
}

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

  final projectCreator = ProjectCreator(
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
