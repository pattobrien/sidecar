import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:sidecar_analyzer_plugin_core/src/services/plugin_generator/packages/sidecar_package_config.dart';
import 'package:yaml/yaml.dart';

Future<SidecarConfig?> parseLintPackage(String root) async {
  final pubspecContent =
      await File(p.join(root, 'pubspec.yaml')).readAsString();
  try {
    return checkedYamlDecode<SidecarConfig>(pubspecContent, (yamlMap) {
      return SidecarConfig.fromYamlMap(yamlMap!['sidecar'] as YamlMap);
    });
  } catch (e) {
    return null;
  }
}
