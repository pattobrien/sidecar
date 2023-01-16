import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class HelloWorld extends LintRule {
  @override
  LintCode get code =>
      const LintCode('hello_world', package: 'hello_world_rules');

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addSimpleStringLiteral(this);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    final stringValue = node.value;
    if (stringValue == 'Is there anybody there?') {
      reportAstNode(node, message: 'Hello world!');
    }
    super.visitSimpleStringLiteral(node);
  }
}
