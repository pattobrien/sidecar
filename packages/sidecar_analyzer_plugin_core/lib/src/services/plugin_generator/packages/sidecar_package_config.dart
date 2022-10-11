import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class SidecarPackageConfig {
  factory SidecarPackageConfig.fromYamlMap(YamlMap map) {
    return SidecarPackageConfig._(
      map['lints'] as YamlList?,
      map['edits'] as YamlList?,
      source: map,
    );
  }

  SidecarPackageConfig._(this._lints, this._edits, {required this.source});

  final YamlList? _lints;
  final YamlList? _edits;
  final YamlMap source;

  List<LintNode>? get lints => _lints?.nodes.map(LintNode.new).toList();
  List<EditNode>? get edits => _edits?.nodes.map(EditNode.new).toList();
}

class LintNode {
  LintNode(this.node) : name = node.value as String;

  final String name;
  final YamlNode node;

  String get className => ReCase(name).pascalCase;
}

class EditNode {
  EditNode(this.node) : name = node.value as String;

  final String name;
  final YamlNode node;

  String get className => ReCase(name).pascalCase;
}

final x = SidecarPackageConfig.fromYamlMap(YamlMap())._lints?.nodes.first;
