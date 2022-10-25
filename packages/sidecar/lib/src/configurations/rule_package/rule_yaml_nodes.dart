import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

abstract class SidecarBaseNode {
  SidecarBaseNode(this.node) : name = node.value as String;
  final String name;
  final YamlNode node;

  String get className => ReCase(name).pascalCase;
}

class LintNode extends SidecarBaseNode {
  LintNode(super.node);
}

class AssistNode extends SidecarBaseNode {
  AssistNode(super.node);
}
