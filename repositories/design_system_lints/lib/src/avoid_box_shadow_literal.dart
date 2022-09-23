import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

class AvoidBoxShadowLiteral extends LintRule {
  AvoidBoxShadowLiteral(super.ref);

  @override
  String get code => 'avoid_box_shadow_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes
        .toDetectedLints(unit, this, message: 'Avoid BoxShadow literal.');
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;

    if (FlutterTypeChecker.isBoxShadow(element?.returnType)) {
      nodes.add(node);
    }
    super.visitInstanceCreationExpression(node);
  }
}
