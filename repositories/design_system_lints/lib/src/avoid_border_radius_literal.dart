import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/builder.dart';

class AvoidBorderRadiusLiteral extends LintRule {
  @override
  String get code => 'avoid_border_radius_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes;
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
