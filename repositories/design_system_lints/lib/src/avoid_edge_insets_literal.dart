import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

class AvoidEdgeInsetsLiteral extends LintRule {
  @override
  String get code => 'avoid_edge_insets_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return visitor.nodes;
  }
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final type = node.constructorName.staticElement?.returnType;

    if (FlutterTypeChecker.isEdgeInsets(type)) {
      reportAstNode(node, message: 'Avoid edge insets literal.');
    }
    super.visitInstanceCreationExpression(node);
  }
}
