import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class SidecarPackage {
  factory SidecarPackage.fromYamlMap(
    YamlMap map, {
    required Uri uri,
    required String packageName,
  }) {
    return SidecarPackage._(
      map['lints'] as YamlList?,
      map['edits'] as YamlList?,
      source: map,
      uri: uri,
      packageName: packageName,
    );
  }

  SidecarPackage._(
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

SidecarPackage? parseLintPackage(String name, Uri root) {
  final pubspecContent =
      File(p.join(root.toFilePath(windows: Platform.isWindows), 'pubspec.yaml'))
          .readAsStringSync();
  try {
    return checkedYamlDecode<SidecarPackage>(pubspecContent, (yamlMap) {
      if (yamlMap?['sidecar'] == null) throw PackageMissingSidecarDefinition();
      return SidecarPackage.fromYamlMap(
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
