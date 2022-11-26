import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class SomeLintVisitor extends SidecarAstVisitor with Lint, QuickFix {
  @override
  LintCode get code => throw UnimplementedError();

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addAdjacentStrings(this);
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    reportAstNode(
      node,
      message: 'message',
      correction: '',
      editsComputer: () async {
        return [];
      },
    );
  }
}
