import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

const kPackage = 'test_lint';
const kName = 'avoid_string_literals';

class AvoidStringLiterals extends LintRule with LintVisitor {
  @override
  RuleCode get code => const LintCode(kName, package: kPackage);

  @override
  SidecarVisitor initializeVisitor(NodeRegistry registry) {
    final visitor = _Visitor();
    registry.addSimpleStringLiteral(this, visitor);
    return visitor;
  }
}

class _Visitor extends SidecarVisitor {
  @override
  void visitStringLiteral(StringLiteral node) {
    if (node.parent is! ImportDirective &&
        node is! PartDirective &&
        node is! PartOfDirective) {
      reportAstNode(node, message: 'Found a string.');
    }

    super.visitStringLiteral(node);
  }
}
