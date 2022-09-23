import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

class AvoidBorderRadiusLiteral extends LintRule {
  AvoidBorderRadiusLiteral(super.ref);

  @override
  String get code => 'avoid_border_radius_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(
      unit,
      this,
      message: 'Avoid BorderRadius literal.',
    );
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement?.returnType.element2;

    if (FlutterTypeChecker.isBorderRadius(element?.thisType)) {
      nodes.add(node);
    }
    super.visitInstanceCreationExpression(node);
  }
}
