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
