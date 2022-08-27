import 'dart:io' as io;
import 'package:path/path.dart' as p;

import '../utilities/utilities.dart';

final kHomeDirectory = homeDirectory();

io.Directory getProjectPluginDirectory(String projectName) => io.Directory(
      p.join(
        kHomeDirectory.path,
        '.sidecar',
        'projects',
        projectName,
        'sidecar_analyzer_plugin',
      ),
    )..create(recursive: true);

final kPluginPackagesRootPath =
    p.join(kHomeDirectory.path, 'Development', 'sidecar', 'packages');

final kAnalyzerPluginPackageRoot =
    io.Directory(p.join(kPluginPackagesRootPath, 'sidecar_analyzer_plugin'));

final kAnalyzerLintRepositoryRoot = io.Directory(
    p.join('/Users/pattobrien/Development/sidecar/', 'lint_repository'));

final lintInitializerRelativePath =
    'sidecar_analyzer_plugin/lib/src/plugin_bootstrapper.dart';

final kPluginLoaderPath = p.join(
  kPluginPackagesRootPath,
  'sidecar_analyzer_plugin',
  'tools',
  'analyzer_plugin',
  'pubspec.yaml',
);

String pluginLoaderYamlContentCreator(String projectPluginPath) => '''
name: sidecar_analyzer_plugin_loader
description: This pubspec determines the version of the analyzer plugin to load.
version: 0.0.1
publish_to: none

environment:
  sdk: ">=2.15.0 <3.0.0"
dependencies:
  sidecar_analyzer_plugin:
    path: $projectPluginPath/sidecar_analyzer_plugin # code-generated
''';
