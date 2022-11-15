// ignore_for_file: implementation_imports, overridden_fields

import 'dart:convert';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:file/file.dart' hide File;
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

import '../../analyzer/server/runner/context_providers.dart';
import '../../configurations/configurations.dart';
import '../../services/active_project_service.dart';
import '../../utils/file_paths.dart';
import 'analysis_options.dart';
import 'resource_mixin.dart';
import 'workspace_resource.dart';

class PackageResource with ResourceMixin {
  PackageResource({
    required this.parentDirectoryPath,
    required this.resourceProvider,
    required this.projectName,
    required this.fileSystem,
    this.isSidecarEnabled = true,
    ProjectConfiguration? sidecarProjectConfiguration,
  }) : _sidecarProjectConfiguration = sidecarProjectConfiguration {
    build();
  }

  @override
  final ResourceProvider resourceProvider;

  @override
  final FileSystem fileSystem;

  @override
  String get rootPath => p.join(parentDirectoryPath, projectName);

  final String parentDirectoryPath;
  final String projectName;

  final ProjectConfiguration? _sidecarProjectConfiguration;

  final bool isSidecarEnabled;

  ProjectConfiguration? get sidecarProjectConfiguration =>
      _sidecarProjectConfiguration;

  Folder get projectFolder =>
      resourceProvider.getFolder(p.join(parentDirectoryPath, projectName));

  void build() {
    final options =
        createAnalysisOptionsContents(isPluginEnabled: isSidecarEnabled);
    newAnalysisOptionsYamlFile(rootPath, options);
    if (sidecarProjectConfiguration != null) {
      final sidecarYamlContents = sidecarProjectConfiguration!.toYamlContent();
      newSidecarOptionsFile(rootPath, sidecarYamlContents);
    }
    _createMainFile();
    final thisPackageConfigUri =
        io.Directory.current.uri.resolve(p.join(kDartTool, kPackageConfigJson));
    final contents =
        resourceProvider.getFile(thisPackageConfigUri.path).readAsStringSync();
    final newPackageConfig =
        PackageConfig.parseString(contents, thisPackageConfigUri);
    // final packageConfig = PackageConfig.empty.addPackage(sidecarPackage);
    // addPackageConfig(packageConfig);
    addPackageConfig(newPackageConfig);
    newPubspecYamlFile(Pubspec(projectName));
    createRunner();
  }

  void createRunner() {
    assert(isSidecarEnabled, 'sidecar isnt enabled');

    final service = workspaceContainer.read(activeProjectServiceProvider);
    final root = Uri(scheme: 'file', path: rootPath);
    final activePackage = service.getActivePackageFromUri(root);
    final collection = AnalysisContextCollection(
      includedPaths: [rootPath],
      resourceProvider: resourceProvider,
    );
    final context = collection.contextFor(rootPath);
    final activeContext = service.getActivePackageFromContext(context);

    if (activeContext == null) {
      throw StateError('Invalid Sidecar directory: $rootPath');
    }

    workspaceContainer.read(runnerActiveContextsProvider.notifier).update = [
      activeContext
    ];
  }

  File newAnalysisOptionsYamlFile(String directoryPath, String content) {
    return newFile(kAnalysisOptionsYaml, content);
  }

  File newPubspecYamlFile(Pubspec pubspec) {
    return newFile(kPubspecYaml, pubspec.toString());
  }

  File newSidecarOptionsFile(String directoryPath, String content) {
    return newFile(kSidecarYaml, content);
  }

  void modifySidecarYaml(ProjectConfiguration configuration) {
    final content = configuration.toYamlContent();
    newFile(kSidecarYaml, content);
  }

  void _createMainFile() {
    newFile(p.join('lib', 'main.dart'), mainContent);
  }

  void addPackageConfig(PackageConfig packageConfig) {
    final json = PackageConfig.toJson(packageConfig);
    final encodedJson = jsonEncode(json);
    newFile(p.join(kDartTool, kPackageConfigJson), encodedJson);
  }

  // void addPackages(
  //   List<Package> packages, {
  //   bool shouldBeEnabledInSidecarYaml = true,
  // }) {
  //   final packageConfigPath = p.join(
  //       directoryPath, file_paths.dotDartTool, file_paths.packageConfigJson);
  //   final packageConfigFile = getFile(packageConfigPath);
  //   if (!packageConfigFile.exists) {
  //     final json = PackageConfig.toJson(PackageConfig.empty);
  //     newFile(
  //       packageConfigPath,
  //       json.toString(),
  //     );
  //   }
  //   final packageConfig = PackageConfig.parseString(
  //       packageConfigFile.readAsStringSync(), packageConfigFile.toUri());
  //   final newPackageConfig = packageConfig.addPackages([]);
  //   final json = PackageConfig.toJson(newPackageConfig);

  //   newPackageConfigJsonFile(json.toString());
  //   if (shouldBeEnabledInSidecarYaml) {
  //     // TODO:
  //     // _sidecarProjectConfiguration = _sidecarProjectConfiguration.copyWith();
  //   }
  // }

  File newPackageConfigJsonFile(String content) {
    return newFile(p.join(rootPath, kDartTool, kPackageConfigJson), content);
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
