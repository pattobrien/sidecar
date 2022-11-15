// ignore_for_file: implementation_imports, overridden_fields

import 'dart:convert';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:analyzer/src/util/file_paths.dart' as file_paths;
import 'package:file/file.dart' hide File;
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

import '../../../sidecar.dart';
import '../../configurations/configurations.dart';
import 'analysis_options.dart';
import 'package_config_extensions.dart';
import 'sidecar_yaml.dart';

DartProject createDartProject({
  required String parentDirectoryPath,
  required OverlayResourceProvider resourceProvider,
  required String projectName,
  required FileSystem fileSystem,
  bool isSidecarEnabled = true,
  ProjectConfiguration? sidecarProjectConfiguration,
}) =>
    DartProject(
        parentDirectoryPath: parentDirectoryPath,
        resourceProvider: resourceProvider,
        projectName: projectName,
        fileSystem: fileSystem,
        isSidecarEnabled: isSidecarEnabled,
        sidecarProjectConfiguration: sidecarProjectConfiguration);

class DartProject {
  DartProject({
    required this.parentDirectoryPath,
    required this.resourceProvider,
    required this.projectName,
    required this.fileSystem,
    this.isSidecarEnabled = true,
    ProjectConfiguration? sidecarProjectConfiguration,
  }) : _sidecarProjectConfiguration = sidecarProjectConfiguration {
    build();
  }

  final OverlayResourceProvider resourceProvider;
  final FileSystem fileSystem;

  final String parentDirectoryPath;
  final String projectName;

  ProjectConfiguration? _sidecarProjectConfiguration;

  final bool isSidecarEnabled;

  ProjectConfiguration? get sidecarProjectConfiguration =>
      _sidecarProjectConfiguration;

  String get directoryPath => p.join(parentDirectoryPath, projectName);
  Folder get projectFolder =>
      resourceProvider.getFolder(p.join(parentDirectoryPath, projectName));

  void build() {
    final options =
        createAnalysisOptionsContents(isPluginEnabled: isSidecarEnabled);
    newAnalysisOptionsYamlFile(directoryPath, options);
    if (sidecarProjectConfiguration != null) {
      final sidecarYamlContents = sidecarProjectConfiguration!.toYamlContent();
      newSidecarOptionsFile(directoryPath, sidecarYamlContents);
    }
    _createMainFile();
    addPackageConfig(PackageConfig.empty);
    newPubspecYamlFile(Pubspec(projectName));
  }

  File newAnalysisOptionsYamlFile(String directoryPath, String content) {
    final path = p.join(directoryPath, sidecarYamlPath);
    return newFile(path, content);
  }

  File newPubspecYamlFile(Pubspec pubspec) {
    final path = p.join(directoryPath, kPubspecYaml);
    return newFile(path, pubspec.toString());
  }

  File getFile(String path) => resourceProvider.getFile(path);
  Folder getFolder(String path) => resourceProvider.getFolder(path);

  File newSidecarOptionsFile(String directoryPath, String content) {
    final path = p.join(directoryPath, sidecarYamlPath);
    return newFile(path, content);
  }

  void modifySidecarYaml(ProjectConfiguration configuration) {
    final content = configuration.toYamlContent();
    newFile(kSidecarYaml, content);
  }

  void _createMainFile() {
    newFile(p.join(directoryPath, 'lib', 'main.dart'), mainContent);
  }

  void addPackageConfig(PackageConfig packageConfig) {
    final content = packageConfig.toString();
    newFile(p.join(directoryPath, kDartTool, kPackageConfigJson), content);
  }

  void addPackages(
    List<Package> packages, {
    bool shouldBeEnabledInSidecarYaml = true,
  }) {
    final packageConfigPath = p.join(
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

    newPackageConfigJsonFile(json.toString());
    if (shouldBeEnabledInSidecarYaml) {
      // TODO:
      // _sidecarProjectConfiguration = _sidecarProjectConfiguration.copyWith();
    }
  }

  File newPackageConfigJsonFile(String content) {
    return newFile(
        p.join(directoryPath, kDartTool, kPackageConfigJson), content);
  }

  Folder newFolder(String path) {
    final folderPath = p.join(directoryPath, path);
    fileSystem.directory(folderPath).createSync(recursive: true);
    return resourceProvider.getFolder(folderPath)..create();
  }

  File newFile(String relativePath, String content) {
    final filePath = p.join(directoryPath, relativePath);
    final file = resourceProvider.getFile(filePath);
    resourceProvider.setOverlay(relativePath,
        content: content,
        modificationStamp: DateTime.now().millisecondsSinceEpoch);
    fileSystem.file(filePath).createSync(recursive: true);
    return file;
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
