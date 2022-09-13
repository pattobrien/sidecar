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

io.Directory kPluginMasterRoot(Version version) =>
    io.Directory(getPluginPackagePathForVersion(version));

final lintInitializerRelativePath = 'lib/src/lint_rule_constructors.dart';
final editInitializerRelativePath = 'lib/src/code_edit_constructors.dart';

String kPluginLoaderAbsolutePath(String packagePath) =>
    p.join(packagePath, kPluginLoaderRelativePath);

final kPluginLoaderRelativePath = p.join(
  'tools',
  'analyzer_plugin',
  'pubspec_overrides.yaml',
);

String pluginLoaderYamlContentCreator(String projectPluginPath) => '''
dependency_overrides:
  sidecar_analyzer_plugin:
    path: $projectPluginPath # code-generated
''';

final sidecarMicropubUri =
    Uri.parse('https://micropub-3qduh.ondigitalocean.app/');
