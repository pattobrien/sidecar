import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

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
  List<EditNode>? get edits => _edits?.nodes.map(EditNode.new).toList();
}

abstract class SidecarBaseNode {
  SidecarBaseNode(this.node) : name = node.value as String;
  final String name;
  final YamlNode node;

  String get className => ReCase(name).pascalCase;
}

class LintNode extends SidecarBaseNode {
  LintNode(super.node);
}

class EditNode extends SidecarBaseNode {
  EditNode(super.node);
}

RulePackageConfiguration? parseLintPackage(String name, Uri root) {
  final rootPath = root.toFilePath(windows: Platform.isWindows);
  final pubspecPath = p.join(rootPath, 'pubspec.yaml');
  final pubspecContent = File(pubspecPath).readAsStringSync();
  try {
    return checkedYamlDecode<RulePackageConfiguration>(pubspecContent,
        (yamlMap) {
      if (yamlMap?['sidecar'] == null) throw PackageMissingSidecarDefinition();
      return RulePackageConfiguration.fromYamlMap(
        yamlMap!['sidecar']! as YamlMap,
        uri: root,
        packageName: name,
      );
    });
  } on PackageMissingSidecarDefinition {
    return null;
  } catch (e) {
    rethrow;
  }
}

class PackageMissingSidecarDefinition implements Exception {}
