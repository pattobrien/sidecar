import 'dart:io' as io;
import 'package:path/path.dart' as p;

import '../utilities/utilities.dart';

final kHomeDirectory = homeDirectory();

final kPluginPackagesRootPath = p.join(
  kHomeDirectory.path,
  'Development',
  'sidecar',
  'packages',
  'sidecar_analyzer_plugin',
);

final kAnalyzerPluginPackageRoot = io.Directory(kPluginPackagesRootPath);

final kAnalyzerLintRepositoryRoot = io.Directory(
    p.join('/Users/pattobrien/Development/sidecar/', 'lint_repository', 'lib'));

final lintInitializerRelativePath = 'lib/src/plugin_bootstrapper.dart';

final kPluginLoaderPath = p.join(
  kPluginPackagesRootPath,
  'tools',
  'analyzer_plugin',
  'pubspec_overrides.yaml',
);

String pluginLoaderYamlContentCreator(String projectPluginPath) => '''
dependency_overrides:
  sidecar_analyzer_plugin:
    path: $projectPluginPath/sidecar_analyzer_plugin # code-generated
''';


// String pluginLoaderYamlContentCreator(String projectPluginPath) => '''
// name: sidecar_analyzer_plugin_loader
// description: This pubspec determines the version of the analyzer plugin to load.
// version: 0.0.1
// publish_to: none

// environment:
//   sdk: ">=2.15.0 <3.0.0"
// dependencies:
//   sidecar_analyzer_plugin:
//     path: $projectPluginPath/sidecar_analyzer_plugin # code-generated
// ''';
