import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends Rule with Lint {
  static const _id = 'example_lint';

  @override
  LintCode get code => LintCode(_id, package: 'example');

  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry..addAdjacentStrings(this);

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    super.visitAdjacentStrings(node);
  }

  @override
  void visitAnnotation(Annotation node) {
    super.visitAnnotation(node);
  }
}

