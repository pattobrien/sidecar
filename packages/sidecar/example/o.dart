import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/rules/visitors.dart';
import 'package:sidecar/src/analyzer/ast/general_visitor.dart';
import 'package:sidecar/src/protocol/models/rule_code.dart';
import 'package:sidecar/src/rules/base_rule.dart';

class SomeLintVisitor extends SidecarAstVisitor with LintMixin, QuickFixMixin {
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
