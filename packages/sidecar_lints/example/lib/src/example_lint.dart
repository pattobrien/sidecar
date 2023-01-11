import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends LintRule {
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

class ExampleLintWithCascade extends LintRule {
  static const _id = 'example_lint_with_cascade';

  @override
  LintCode get code => LintCode(_id, package: 'example');

  @override
  void initializeVisitor(NodeRegistry registry) => registry
    ..addAdjacentStrings(this)
    ..addAnnotation(this);

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    super.visitAdjacentStrings(node);
  }

  @override
  void visitAnnotation(Annotation node) {
    super.visitAnnotation(node);
  }
}

class ExampleLintWithFunctionBlock extends LintRule {
  static const _id = 'example_lint_with_cascade';

  @override
  LintCode get code => LintCode(_id, package: 'example');

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

class ExampleLintWithFunctionBlockWithReturn extends LintRule {
  static const _id = 'example_lint_with_function_block_with_return';

  @override
  LintCode get code => LintCode(_id, package: 'example');

  @override
  void initializeVisitor(NodeRegistry registry) {
    return registry.addAdjacentStrings(this);
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    super.visitAdjacentStrings(node);
  }
}
