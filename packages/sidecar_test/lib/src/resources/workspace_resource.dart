// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/sidecar_spec/sidecar_spec.dart';
import 'package:sidecar/src/analyzer/providers/providers.dart';
import 'package:sidecar/src/server/server_providers.dart';

import 'package_resource.dart';
import 'resource_mixin.dart';

const _defaultWorkspacePath = 'workspace';

late ProviderContainer workspaceContainer;

WorkspaceResource createWorkspace({
  required List<SidecarBaseConstructor> constructors,
  ResourceProvider? resourceProvider,
  FileSystem? fileSystem,
  ProviderContainer? container,
  String? rootPath,
}) {
  workspaceContainer = ProviderContainer(overrides: [
    ruleConstructorProvider.overrideWithValue(constructors),
  ]);
  final fileSystem = workspaceContainer.read(fileSystemProvider);
  final defaultProvider = workspaceContainer.read(serverResourceProvider);
  final provider = resourceProvider ?? defaultProvider;
  final root =
      p.join(io.Directory.systemTemp.uri.toFilePath(), _defaultWorkspacePath);
  // print('workspace root: ${root.path}');
  // final uuidPath = const Uuid().v4();
  final workspace = WorkspaceResource(
      resourceProvider: provider,
      fileSystem: fileSystem,
      rootPath: rootPath ?? root);

  // addTearDown(() => workspace.delete());
  workspace.init();
  return workspace;
}

class WorkspaceResource with ResourceMixin {
  WorkspaceResource({
    this.rootPath = _defaultWorkspacePath,
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

  void init() {
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

  PackageResource createDartPackage({
    String? name,
    String? parentDirectoryPath,
    bool isSidecarEnabled = true,
    SidecarSpec? sidecarYaml,
  }) {
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
    _controller.close();
    for (final package in _packages) {
      randomNames.add(package.projectName);
    }
    _packages.clear();
  }
}

final randomNames = <String>['north_app', 'west_app', 'east_app', 'south_app'];
