import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidBorderRadiusLiteral extends LintRule with LintVisitor {
  @override
  String get code => 'avoid_border_radius_literal';

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
    if (borderRadiusType.isAssignableFromType(element?.returnType)) {
      reportAstNode(node, message: 'Avoid BorderRadius literal.');
    }
    super.visitInstanceCreationExpression(node);
  }
}
