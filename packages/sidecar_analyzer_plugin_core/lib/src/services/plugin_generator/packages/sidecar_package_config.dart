import 'package:yaml/yaml.dart';

class SidecarConfig {
  factory SidecarConfig.fromYamlMap(YamlMap map) {
    return SidecarConfig._(
      map['lints'] as YamlList,
      map['edits'] as YamlList,
      source: map,
    );
  }

  SidecarConfig._(this._lints, this._edits, {required this.source});

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
}

class EditNode {
  EditNode(this.node) : name = node.value as String;

  final String name;
  final YamlNode node;
}

final x = SidecarConfig.fromYamlMap(YamlMap())._lints?.nodes.first;
