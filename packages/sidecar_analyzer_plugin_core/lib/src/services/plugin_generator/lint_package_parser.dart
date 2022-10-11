import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'packages/sidecar_package_config.dart';

Future<SidecarPackageConfig?> parseLintPackage(Uri root) async {
  final pubspecContent = await File(
          p.join(root.toFilePath(windows: Platform.isWindows), 'pubspec.yaml'))
      .readAsString();
  try {
    return checkedYamlDecode<SidecarPackageConfig>(pubspecContent, (yamlMap) {
      if (yamlMap?['sidecar'] == null) throw PackageMissingSidecarDefinition();
      return SidecarPackageConfig.fromYamlMap(yamlMap!['sidecar']! as YamlMap);
    });
  } on PackageMissingSidecarDefinition {
    return null;
  } catch (e) {
    rethrow;
  }
}

class PackageMissingSidecarDefinition implements Exception {}
