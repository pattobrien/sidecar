import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/builder.dart';

class AvoidBoxShadowLiteral extends LintRule {
  @override
  String get code => 'avoid_box_shadow_literal';

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
    final element = node.constructorName.staticElement;

    if (FlutterTypeChecker.isBoxShadow(element?.returnType)) {
      reportAstNode(node, message: 'Avoid BoxShadow literal');
    }
    super.visitInstanceCreationExpression(node);
  }
}
