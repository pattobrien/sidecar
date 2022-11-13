import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'rule_yaml_nodes.dart';

// @JsonSerializable(anyMap: true)
class RulePackageConfiguration {
  factory RulePackageConfiguration.fromYamlMap(
    YamlMap map, {
    required Uri uri,
    required String packageName,
  }) {
    return RulePackageConfiguration(
      map['lints'] as YamlList?,
      map['assists'] as YamlList?,
      source: map,
      uri: uri,
      packageName: packageName,
    );
  }

  RulePackageConfiguration(
    this.yamlLints,
    this.yamlAssists, {
    required this.source,
    required this.packageName,
    required this.uri,
  });

  final YamlList? yamlLints;
  final YamlList? yamlAssists;
  final YamlMap source;

  final String packageName;
  final Uri uri;

  List<LintNode>? get lints => yamlLints?.nodes.map(LintNode.new).toList();
  List<AssistNode>? get assists =>
      yamlAssists?.nodes.map(AssistNode.new).toList();
}

RulePackageConfiguration? parseLintPackage(String name, Uri root) {
  final rootPath = root.toFilePath(windows: Platform.isWindows);
  final pubspecPath = p.join(rootPath, 'pubspec.yaml');
  final pubspecContent = File(pubspecPath).readAsStringSync();
  try {
    return checkedYamlDecode<RulePackageConfiguration?>(pubspecContent,
        (yamlMap) {
      if (yamlMap?['sidecar'] == null) return null;
      return RulePackageConfiguration.fromYamlMap(
        yamlMap!['sidecar']! as YamlMap,
        uri: root,
        packageName: name,
      );
    });
  } catch (e) {
    return null;
  }
}
