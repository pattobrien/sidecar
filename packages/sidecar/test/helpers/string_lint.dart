import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

const kPackage = 'test_lint';
const kName = 'avoid_string_literals';
const kAvoidStringLiteralsCode = LintCode(kName, package: kPackage);

class AvoidStringLiterals extends LintRule with LintVisitor {
  @override
  RuleCode get code => kAvoidStringLiteralsCode;

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
