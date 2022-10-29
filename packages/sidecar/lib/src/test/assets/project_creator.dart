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
    this.lintPackages = const [],
    this.assistPackages = const [],
  }) {
    build();
  }

  @override
  final MemoryResourceProvider resourceProvider;
  final String parentDirectoryPath;
  final String projectName;

  final bool isSidecarEnabled;
  final List<LintPackageConfiguration> lintPackages;
  final List<AssistPackageConfiguration> assistPackages;

  String get directoryPath => join(parentDirectoryPath, projectName);
  Folder get projectFolder => getFolder(join(parentDirectoryPath, projectName));

  void build() {
    final analysisOptionsContents = createAnalysisOptionsContents();
    newAnalysisOptionsYamlFile(directoryPath, analysisOptionsContents);

    final sidecarYamlContents = createSidecarYamlContents();
    newSidecarOptionsFile(directoryPath, sidecarYamlContents);
  }

  File newSidecarOptionsFile(String directoryPath, String content) {
    final path = join(directoryPath, sidecarYamlPath);
    return newFile(path, content);
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
