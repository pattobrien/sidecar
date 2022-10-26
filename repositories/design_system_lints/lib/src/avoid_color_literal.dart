import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidColorLiteral extends LintRule with LintVisitor {
  @override
  String get code => 'avoid_color_literal';

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
    // if (colorType.isAssignableFromType(element.returnType)) {
    //   reportAstNode(node, message: 'Avoid Color literal');
    // }

    super.visitInstanceCreationExpression(node);
  }
}
