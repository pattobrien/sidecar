import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class AvoidStringLiterals extends LintRule with LintVisitor {
  @override
  String get code => 'avoid_string_literals';

  @override
  String get packageName => 'test_lint';

  @override
  SidecarAstVisitor Function() get visitorCreator => _Visitor.new;
}

class _Visitor extends SidecarAstVisitor {
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
