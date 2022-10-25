import 'dart:async';
// import 'dart:';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidColorLiteral extends LintRule {
  @override
  String get code => 'avoid_color_literal';

  @override
  String get packageName => kDesignSystemPackageId;

  @override
  String? get url => kUrl;

  @override
  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.nodes);
  }
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (element != null) {
      // if (colorType.isAssignableFromType(element.returnType)) {
      //   reportAstNode(node, message: 'Avoid Color literal');
      // }
    }

    super.visitInstanceCreationExpression(node);
  }
}
