import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart';

import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:sidecar/src/test/assets/project_creator.dart';
import 'package:sidecar/src/test/assets/pub_cache_creator.dart';
import 'package:sidecar/src/test/utils.dart';

const kL10nPackageName = 'l10n_lints';
const kL10nAvoidStringLiteralsLintId = 'avoid_string_literals';

Future<void> main() async {
  final resourceProvider = MemoryResourceProvider();
  final physicalResourceProvider = PhysicalResourceProvider.INSTANCE;

  final workspaceCreator = WorkspaceCreator(resourceProvider: resourceProvider);

  const projectConfig = ProjectConfiguration(lintPackages: {
    kL10nPackageName: LintPackageConfiguration(lints: {
      kL10nAvoidStringLiteralsLintId:
          LintConfiguration(severity: LintSeverity.error),
    })
  });

  final pubCacheCreator = PubCacheCreator(
    resourceProvider: resourceProvider,
    physicalResourceProvider: physicalResourceProvider,
  );

  final projectCreator = ProjectCreator(
    resourceProvider: resourceProvider,
    parentDirectoryPath: workspaceCreator.workspaceFolder.path,
    projectName: 'my_app',
    sidecarProjectConfiguration: projectConfig,
  );
  projectCreator.addPackages([]);

  final packagesSubfolder = projectCreator.newFolder('packages');

  final subProjectCreator = ProjectCreator(
    parentDirectoryPath: packagesSubfolder.path,
    resourceProvider: resourceProvider,
    projectName: 'my_backend_client',
    isSidecarEnabled: false,
  );

  final collection = createTestContextForPath(
    projectCreator.projectFolder.path,
    resourceProvider: resourceProvider,
    sdkPath: workspaceCreator.sdkFolder.path,
  );

  // print(collection.contexts.length);

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
