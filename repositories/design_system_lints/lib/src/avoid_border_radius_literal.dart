import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidBorderRadiusLiteral extends LintRule {
  @override
  String get code => 'avoid_border_radius_literal';

  @override
  String get packageName => kDesignSystemPackageId;

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
    final element = node.constructorName.staticElement?.returnType.element2;

    if (FlutterTypeChecker.isBorderRadius(element?.thisType)) {
      reportAstNode(node, message: 'Avoid BorderRadius literal.');
    }
    super.visitInstanceCreationExpression(node);
  }
}
