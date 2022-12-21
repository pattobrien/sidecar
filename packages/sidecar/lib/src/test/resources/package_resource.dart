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

import '../../configurations/sidecar_spec/sidecar_spec_base.dart';
import '../../server/server_providers.dart';
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
    SidecarSpec? sidecarProjectConfiguration,
  }) : _sidecarProjectConfiguration = sidecarProjectConfiguration {
    build();
  }

  @override
  final ResourceProvider resourceProvider;

  @override
  final FileSystem fileSystem;

  @override
  String get rootPath => p.join(parentDirectoryPath, projectName);

  Uri get root => Uri.parse(rootPath);

  final String parentDirectoryPath;
  final String projectName;

  final SidecarSpec? _sidecarProjectConfiguration;

  final bool isSidecarEnabled;

  SidecarSpec? get sidecarProjectConfiguration => _sidecarProjectConfiguration;

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
    // _createMainFile();
    print('current directory: ${io.Directory.current.uri.toFilePath()}');
    // final thisPackageConfigUri =
    //     io.Directory.current.uri.resolve(p.join(kDartTool, kPackageConfigJson));
    // print('thisPackageConfigUri: ${thisPackageConfigUri.toFilePath()}');
    final newFilePath = Uri.file(p.join(
        io.Directory.current.uri.toFilePath(), kDartTool, kPackageConfigJson));
    print('thisPackageConfigUri: ${newFilePath.toFilePath()}');
    final contents =
        resourceProvider.getFile(newFilePath.toFilePath()).readAsStringSync();
    final newPackageConfig = PackageConfig.parseString(
        contents, Uri(scheme: 'file', path: newFilePath.toFilePath()));
    // final packageConfig = PackageConfig.empty.addPackage(sidecarPackage);
    // addPackageConfig(packageConfig);
    addPackageConfig(newPackageConfig);
    newPubspecYamlFile(Pubspec(projectName));
    createRunner();
  }

  void createRunner() {
    assert(isSidecarEnabled, 'sidecar isnt enabled');

    final service = workspaceContainer.read(activeProjectServiceProvider);
    // final root = Uri(scheme: 'file', path: rootPath);
    // final activePackage = service.getActivePackageFromUri(root);
    final collection = AnalysisContextCollection(
      includedPaths: [rootPath],
      resourceProvider: resourceProvider,
    );
    final context = collection.contextFor(rootPath);
    final activeContext = service.getActivePackageFromContext(context);

    if (activeContext == null) {
      // throw StateError('Invalid Sidecar directory: $rootPath');
      workspaceContainer.read(runnerActiveContextProvider.notifier).state = [];
    } else {
      workspaceContainer.read(runnerActiveContextProvider.notifier).state = [
        activeContext
      ];
    }
  }

  File newAnalysisOptionsYamlFile(String directoryPath, String content) {
    return modifyFile(kAnalysisOptionsYaml, content);
  }

  File newPubspecYamlFile(Pubspec pubspec) {
    final sidecarPackagePath = io.Directory.current.path;
    final content = '''
name: $projectName

environment:
  sdk: ">=2.17.5 <3.0.0"

dependencies:
  path: ^1.8.0
  intl_lints: ^0.1.0-dev.7

dependency_overrides:
  sidecar:
    path: $sidecarPackagePath
''';
    return modifyFile(kPubspecYaml, content);
  }

  File newSidecarOptionsFile(String directoryPath, String content) {
    return modifyFile(kSidecarYaml, content);
  }

  void modifySidecarYaml(SidecarSpec configuration) {
    final content = configuration.toYamlContent();
    modifyFile(kSidecarYaml, content);
  }

  void addPackageConfig(PackageConfig packageConfig) {
    final json = PackageConfig.toJson(packageConfig);
    final encodedJson = jsonEncode(json);
    modifyFile(p.join(kDartTool, kPackageConfigJson), encodedJson);
  }

  File newPackageConfigJsonFile(String content) {
    return modifyFile(p.join(rootPath, kDartTool, kPackageConfigJson), content);
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
