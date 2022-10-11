import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:sidecar_analyzer_plugin_core/src/services/plugin_generator/packages/sidecar_package_config.dart';
import 'package:yaml/yaml.dart';

Future<SidecarPackageConfig?> parseLintPackage(Uri root) async {
  final pubspecContent =
      await File(p.join(root.toFilePath(), 'pubspec.yaml')).readAsString();
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
