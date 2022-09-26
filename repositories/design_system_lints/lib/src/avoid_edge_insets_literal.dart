import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

class AvoidEdgeInsetsLiteral extends LintRule {
  @override
  String get code => 'avoid_edge_insets_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes
        .toDetectedLints(unit, this, message: 'Avoid edge insets literal.');
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final type = node.constructorName.staticElement?.returnType;

    if (FlutterTypeChecker.isEdgeInsets(type)) {
      nodes.add(node);
    }
    super.visitInstanceCreationExpression(node);
  }
}
