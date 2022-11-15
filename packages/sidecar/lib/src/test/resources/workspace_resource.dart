// ignore_for_file: close_sinks, implementation_imports

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../../analyzer/plugin/files_provider.dart';
import '../../analyzer/plugin/plugin.dart';
import '../../analyzer/plugin/sidecar_analyzer.dart';
import '../../analyzer/server/runner/context_providers.dart';
import '../../analyzer/server/runner/runner_providers.dart';
import '../../analyzer/server/server.dart';
import '../../configurations/configurations.dart';
import '../../protocol/constants/constants.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../../utils/utils.dart';
import 'mock_communication_channel.dart';
import 'package_resource.dart';
import 'resource_mixin.dart';

const defaultWorkspacePath = 'workspace';

late ProviderContainer workspaceContainer;
final mockChannel = MockCommunicationChannel();

Future<WorkspaceResource> createWorkspace({
  required List<SidecarBaseConstructor> constructors,
  ResourceProvider? resourceProvider,
  FileSystem? fileSystem,
  ProviderContainer? container,
  String? rootPath,
}) async {
  final fileSystem = MemoryFileSystem();
  // final hybridProvider = HybridResourceProvider(
  //     physical: PhysicalResourceProvider.INSTANCE,
  //     memory: MemoryResourceProvider());
  // final provider = PhysicalResourceProvider.INSTANCE;
  workspaceContainer = ProviderContainer(overrides: [
    communicationChannelProvider.overrideWithValue(mockChannel),
    ruleConstructorProvider.overrideWithValue(constructors),
    // middlemanResourceProvider.overrideWithValue(provider),
    // runnerResourceProvider.overrideWithValue(provider),
    // activePackageProvider.overrideWithProvider(packageProvider),
    // analyzerResourceProvider.overrideWithValue(pro),
    fileSystemProvider.overrideWithValue(fileSystem),
  ]);
  final defaultProvider = workspaceContainer.read(runnerResourceProvider);
  final provider = resourceProvider ?? defaultProvider;
  final stateFolder = provider.getStateLocation(kSidecarPluginName)!;
  final path = join(stateFolder.path, defaultWorkspacePath);
  final workspace = WorkspaceResource(
      resourceProvider: provider, fileSystem: fileSystem, rootPath: path);

  await workspace.init();
  return workspace;
}

class WorkspaceResource with ResourceMixin {
  WorkspaceResource({
    this.rootPath = defaultWorkspacePath,
    required this.resourceProvider,
    required this.fileSystem,
  });

  ProviderContainer get container => workspaceContainer;

  @override
  final ResourceProvider resourceProvider;

  @override
  final FileSystem fileSystem;

  @override
  final String rootPath;

  Folder get folder => resourceProvider.getFolder(rootPath);

  Future<void> init() async {
    //
  }

  Future<void> refreshRunners() async {
    final runners = container.read(runnersProvider);
    for (final runner in runners) {
      runner.lints.listen(_controller.add);
      await runner.initialize();
    }
  }

  final _controller = StreamController<LintNotification>();

  Stream<LintNotification> get lintStream => _controller.stream;

  Future<PackageResource> createDartPackage(
    String name, {
    String? parentDirectoryPath,
    bool isSidecarEnabled = true,
    ProjectConfiguration? sidecarYaml,
  }) async {
    final package = PackageResource(
        parentDirectoryPath: parentDirectoryPath ?? rootPath,
        resourceProvider: resourceProvider,
        projectName: name,
        fileSystem: fileSystem,
        isSidecarEnabled: isSidecarEnabled,
        sidecarProjectConfiguration: sidecarYaml);
    await refreshRunners();
    return package;
  }
}
