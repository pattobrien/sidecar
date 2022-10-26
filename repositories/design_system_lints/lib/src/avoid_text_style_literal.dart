import 'package:analyzer/dart/ast/ast.dart';
import 'package:design_system_lints/src/constants.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

class AvoidTextStyleLiteral extends LintRule with LintVisitor {
  @override
  String get code => 'avoid_text_style_literal';

  @override
  String get packageName => kDesignSystemPackageId;

  @override
  String get url => kUrl;

  @override
  SidecarAstVisitor get visitor => _Visitor();
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (textStyleType.isAssignableFromType(element?.returnType)) {
      reportAstNode(node, message: r'Avoid TextStyle literal.');
    }
    super.visitInstanceCreationExpression(node);
  }
}
