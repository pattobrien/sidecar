import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'rule_yaml_nodes.dart';

class RulePackageConfiguration {
  factory RulePackageConfiguration.fromYamlMap(
    YamlMap map, {
    required Uri uri,
    required String packageName,
  }) {
    return RulePackageConfiguration._(
      map['lints'] as YamlList?,
      map['edits'] as YamlList?,
      source: map,
      uri: uri,
      packageName: packageName,
    );
  }

  RulePackageConfiguration._(
    this._lints,
    this._edits, {
    required this.source,
    required this.packageName,
    required this.uri,
  });

  final YamlList? _lints;
  final YamlList? _edits;
  final YamlMap source;

  final String packageName;
  final Uri uri;

  List<LintNode>? get lints => _lints?.nodes.map(LintNode.new).toList();
  List<AssistNode>? get edits => _edits?.nodes.map(AssistNode.new).toList();
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
  } catch (e, stackTrace) {
    // do nothing
    return null;
  }
}
