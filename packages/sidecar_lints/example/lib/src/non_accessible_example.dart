import 'package:sidecar/sidecar.dart';
import 'package:analyzer/dart/ast/ast.dart';

class NonAccessibleExampleLint extends LintRule {
  @override
  LintCode get code =>
      LintCode('non_accessible_example_lint', package: 'example');

  @override
  void initializeVisitor(NodeRegistry registry) {
    // TODO: implement initializeVisitor
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    // TODO: implement visitAdjacentStrings
    super.visitAdjacentStrings(node);
  }
}
