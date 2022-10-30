import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:path/path.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/test/assets/project_creator.dart';
import 'package:sidecar/src/test/utils.dart';

const kL10nPackageName = 'l10n_lints';
const kL10nAvoidStringLiteralsLintId = 'avoid_string_literals';

Future<void> main() async {
  final resourceProvider = MemoryResourceProvider();
  final workspaceCreator = WorkspaceCreator(resourceProvider: resourceProvider);

  const l10nPackage = LintPackageConfiguration(
      lints: {kL10nAvoidStringLiteralsLintId: LintConfiguration()});

  const projectConfig =
      ProjectConfiguration(lintPackages: {kL10nPackageName: l10nPackage});

  final projectCreator = ProjectCreator(
    resourceProvider: resourceProvider,
    parentDirectoryPath: workspaceCreator.workspaceFolder.path,
    projectName: 'my_app',
    sidecarProjectConfiguration: projectConfig,
  );

  final packagesSubfolder = projectCreator.newFolder('packages');
  final subProjectCreator = ProjectCreator(
    parentDirectoryPath: packagesSubfolder.path,
    resourceProvider: resourceProvider,
    projectName: 'my_backend_client',
    isSidecarEnabled: false,
  );

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
    final root = context.contextRoot.root;
    print('$root plugins: ${context.analysisOptions.enabledPluginNames}');
    final session = context.currentSession;
    final mainFile = root.canonicalizePath(join('lib', 'main.dart'));
    final unit = await session.getResolvedUnit(mainFile);
    if (unit is ResolvedUnitResult) {
      print('unit exists!');
    } else {
      print('unit does not exist.');
    }
  }
}
