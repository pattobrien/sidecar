// ignore_for_file: implementation_imports, overridden_fields

import 'dart:convert';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';
import 'package:analyzer/src/util/file_paths.dart' as file_paths;
import 'package:package_config/package_config.dart';

import '../../configurations/configurations.dart';
import 'analysis_options.dart';
import 'package_config_extensions.dart';
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
  final ProjectConfiguration? sidecarProjectConfiguration;

  String get directoryPath => join(parentDirectoryPath, projectName);
  Folder get projectFolder => getFolder(join(parentDirectoryPath, projectName));

  void build() {
    final analysisOptionsContents = createAnalysisOptionsContents(
      isSidecarPluginEnabled: isSidecarEnabled,
    );
    newAnalysisOptionsYamlFile(directoryPath, analysisOptionsContents);
    if (sidecarProjectConfiguration != null) {
      final sidecarYamlContents = sidecarProjectConfiguration!.toYamlContent();
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

  void addPackages(List<Package> packages) {
    final packageConfigPath = join(
        directoryPath, file_paths.dotDartTool, file_paths.packageConfigJson);
    final packageConfigFile = getFile(packageConfigPath);
    if (!packageConfigFile.exists) {
      final json = PackageConfig.toJson(PackageConfig.empty);
      newFile(
        packageConfigPath,
        jsonEncode(json),
      );
    }
    final packageConfig = PackageConfig.parseString(
        packageConfigFile.readAsStringSync(), packageConfigFile.toUri());
    final newPackageConfig = packageConfig.addPackages([]);
    final json = PackageConfig.toJson(newPackageConfig);
    newPackageConfigJsonFile(directoryPath, json.toString());
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
