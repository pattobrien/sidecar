import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends Rule with Lint {
  @override
  LintCode get code => LintCode('example_lint', package: 'example');


  @override
  void initializeVisitor(NodeRegistry registry) {
    registry
      ..addAdjacentStrings(this)
      ..addAnnotation(this);
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    super.visitAdjacentStrings(node);
  }

  @override
  void visitAnnotation(Annotation node) {
    super.visitAnnotation(node);
  }

  @override
  void visitArgumentList(ArgumentList node) {
    super.visitArgumentList(node);
  }
}
