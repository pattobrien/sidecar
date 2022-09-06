import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';

import '../utilities/utilities.dart';

final kHomeDirectory = homeDirectory();

final kPluginMasterRootPath = p.join(
  kHomeDirectory.path,
  '.pub-cache',
  'hosted',
  'dart.cloudsmith.io%47fine-designs%47sidecar_analyzer_plugin%47',
);

String getPluginPackagePathForVersion(Version version) => p.join(
      kPluginMasterRootPath,
      'sidecar_analyzer_plugin-${version.canonicalizedVersion}',
    );

final kCloudsmithSidecarUrl =
    'https://dart.cloudsmith.io/fine-designs/sidecar/';

// final kCloudsmithPluginUrl =
//     'https://dart.cloudsmith.io/fine-designs/sidecar_analyzer_plugin/';

io.Directory kPluginMasterRoot(Version version) =>
    io.Directory(getPluginPackagePathForVersion(version));

final kAnalyzerLintRepositoryRoot = io.Directory(
  p.join('/Users/pattobrien/Development/sidecar/', 'repositories', 'lints'),
);

final lintInitializerRelativePath = 'lib/src/plugin_bootstrapper.dart';

String kPluginLoaderAbsolutePath(String packagePath) =>
    p.join(packagePath, kPluginLoaderRelativePath);

final kPluginLoaderRelativePath = p.join(
  'tools',
  'analyzer_plugin',
  'pubspec_overrides.yaml',
);

String lintDependency(String lintName) => '''
  $lintName:
    hosted: http://0.0.0.0:8080
''';

String pluginLoaderYamlContentCreator(String projectPluginPath) => '''
dependency_overrides:
  sidecar_analyzer_plugin:
    path: $projectPluginPath # code-generated
''';

final sidecarMicropubUri = Uri.parse('http://localhost:8080');
