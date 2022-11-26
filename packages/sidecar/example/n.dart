import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:sidecar/rules/rules.dart';
import 'package:sidecar/sidecar.dart';

class SomeLintVisitor extends SidecarAstVisitor with LintMixin, QuickFixMixin {
  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addAdjacentStrings(this);
  }

  @override
  LintCode get code =>
      const LintCode('some_code', package: 'some_lint_package');

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    reportAstNode(node, message: '', editsComputer: () async {
      // final unit = context.currentUnit;
      return [];
    });
    super.visitAdjacentStrings(node);
  }
}
