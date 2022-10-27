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
  SidecarAstVisitor Function() get visitorCreator => _Visitor.new;
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (textStyleType.isAssignableFromType(element?.returnType)) {
      reportAstNode(
        node,
        message: r'Avoid TextStyle literal.',
        correction: 'Use design system spec instead.',
      );
    }
    super.visitInstanceCreationExpression(node);
  }
}
