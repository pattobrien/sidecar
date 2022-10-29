import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/test/assets/project_creator.dart';
import 'package:sidecar/src/test/utils.dart';

void main() {
  final resourceProvider = MemoryResourceProvider();
  final workspaceCreator = WorkspaceCreator(resourceProvider: resourceProvider);

  final projectCreator = ProjectCreator(
    resourceProvider: resourceProvider,
    parentDirectoryPath: workspaceCreator.workspaceFolder.path,
    projectName: 'my_app',
  );

  final packagesSubfolder = projectCreator.newFolder('packages');
  final subProjectCreator = ProjectCreator(
      parentDirectoryPath: packagesSubfolder.path,
      resourceProvider: resourceProvider,
      projectName: 'my_backend_client');
  // final lintPackages = LintPackageConfiguration(
  //     packageName: 'packageName',
  //     packageNameSpan: packageNameSpan,
  //     lints: lints);
  // final lintConfiguration1 = LintConfiguration(
  //     id: 'avoid_edge_insets_literals',
  //     packageName: packageName,
  //     lintNameSpan: lintNameSpan);

  final collection = createTestContextForPath(
    projectCreator.projectFolder.path,
    resourceProvider: resourceProvider,
    sdkPath: workspaceCreator.sdkFolder.path,
  );

  print(collection.contexts.length);

  // final context = collection.contexts.first;
  for (final context in collection.contexts) {
    final path = context.contextRoot.root.path;
    print('$path plugins: ${context.analysisOptions.enabledPluginNames}');
  }
}
