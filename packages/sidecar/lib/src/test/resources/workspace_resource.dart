// ignore_for_file: close_sinks, implementation_imports

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:test/test.dart';

import '../../analyzer/plugin/files_provider.dart';
import '../../analyzer/plugin/plugin.dart';
import '../../analyzer/server/runner/context_providers.dart';
import '../../configurations/configurations.dart';
import '../../configurations/sidecar_spec/sidecar_spec.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import 'package_resource.dart';
import 'resource_mixin.dart';

const defaultWorkspacePath = 'workspace';

late ProviderContainer workspaceContainer;

Future<WorkspaceResource> createWorkspace({
  required List<SidecarBaseConstructor> constructors,
  ResourceProvider? resourceProvider,
  FileSystem? fileSystem,
  ProviderContainer? container,
  String? rootPath,
}) async {
  workspaceContainer = ProviderContainer(overrides: [
    ruleConstructorProvider.overrideWithValue(constructors),
  ]);
  final fileSystem = workspaceContainer.read(fileSystemProvider);
  final defaultProvider = workspaceContainer.read(runnerResourceProvider);
  final provider = resourceProvider ?? defaultProvider;
  final root =
      io.Directory.systemTemp.uri.resolve(p.join(defaultWorkspacePath));
  // final uuidPath = const Uuid().v4();
  final workspace = WorkspaceResource(
      resourceProvider: provider,
      fileSystem: fileSystem,
      rootPath: rootPath ?? root.path);

  addTearDown(() => workspace.delete());
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

  final List<PackageResource> _packages = [];

  List<PackageResource> get packages => _packages;

  Folder get folder => resourceProvider.getFolder(rootPath);

  Future<void> init() async {
    folder.create();
  }

  ContextLocator get locator =>
      ContextLocator(resourceProvider: resourceProvider);

  // Future<void> refreshRunners() async {
  //   final runners = container.read(runnersProvider);
  //   for (final runner in runners) {
  //     runner.lints.listen(_controller.add);
  //     await runner.initialize();
  //     final roots = locator.locateRoots(includedPaths: [rootPath]);
  //     await runner.asyncRequest(request);
  //   }
  // }

  final _controller = StreamController<LintNotification>();

  Stream<LintNotification> get lintStream => _controller.stream;

  Future<PackageResource> createDartPackage({
    String? name,
    String? parentDirectoryPath,
    bool isSidecarEnabled = true,
    SidecarSpec? sidecarYaml,
  }) async {
    final package = PackageResource(
        parentDirectoryPath: parentDirectoryPath ?? rootPath,
        resourceProvider: resourceProvider,
        projectName: name ?? randomNames.removeAt(0),
        fileSystem: fileSystem,
        isSidecarEnabled: isSidecarEnabled,
        sidecarProjectConfiguration: sidecarYaml);
    _packages.add(package);
    return package;
  }

  void deleteDartPackage(PackageResource package) {
    final packageFolder = package.projectFolder;
    packageFolder.delete();
  }

  void delete() {
    folder.delete();
  }
}

final randomNames = <String>['north_app', 'west_app', 'east_app', 'south_app'];
