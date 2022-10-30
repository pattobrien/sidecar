// ignore_for_file: implementation_imports, overridden_fields

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';

import '../../configurations/configurations.dart';
import 'analysis_options.dart';
import 'sidecar_yaml.dart';

class ProjectCreator with ResourceProviderMixin {
  ProjectCreator({
    required this.parentDirectoryPath,
    required this.resourceProvider,
    required this.projectName,
    this.isSidecarEnabled = true,
    this.sidecarProjectConfiguration,
  }) {
    build();
  }

  @override
  final MemoryResourceProvider resourceProvider;
  final String parentDirectoryPath;
  final String projectName;

  final bool isSidecarEnabled;
  // final List<LintPackageConfiguration> lintPackages;
  // final List<AssistPackageConfiguration> assistPackages;
  final ProjectConfiguration? sidecarProjectConfiguration;

  String get directoryPath => join(parentDirectoryPath, projectName);
  Folder get projectFolder => getFolder(join(parentDirectoryPath, projectName));

  void build() {
    final analysisOptionsContents = createAnalysisOptionsContents(
      isSidecarPluginEnabled: isSidecarEnabled,
    );
    newAnalysisOptionsYamlFile(directoryPath, analysisOptionsContents);
    if (sidecarProjectConfiguration != null) {
      final sidecarYamlContents =
          createSidecarYamlContents(sidecarProjectConfiguration!);
      newSidecarOptionsFile(directoryPath, sidecarYamlContents);
    }
    _createMainFile();
  }

  File newSidecarOptionsFile(String directoryPath, String content) {
    final path = join(directoryPath, sidecarYamlPath);
    return newFile(path, content);
  }

  void _createMainFile() {
    newFile(join('lib', 'main.dart'), mainContent);
  }

  @override
  Folder newFolder(String path) {
    return super.newFolder(join(directoryPath, path));
  }

  @override
  File newFile(String path, String content) {
    return super.newFile(join(directoryPath, path), content);
  }
}

const mainContent = '''
void main() {
  final abc = 'string value';
}
''';

class WorkspaceCreator {
  WorkspaceCreator({
    required this.resourceProvider,
  }) {
    build();
  }

  final MemoryResourceProvider resourceProvider;
  Folder get sdkFolder => resourceProvider.getFolder('/sdk');
  Folder get workspaceFolder => resourceProvider.getFolder('/workspace');

  void build() {
    createMockSdk(
      resourceProvider: resourceProvider,
      root: sdkFolder,
    );
  }
}
