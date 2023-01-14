import 'package:sidecar/sidecar.dart';
import 'package:analyzer/dart/ast/ast.dart';

class HelloWorld extends Rule with Lint {
  @override
  LintCode get code => LintCode('hello_world', package: 'hello_world_rules');

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addSimpleStringLiteral(this);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    if (node.stringValue == 'Is anyone out there?') {
      reportAstNode(node, message: 'Hello world!');
    }
    super.visitSimpleStringLiteral(node);
  }
}
