import 'dart:async';

import 'package:sidecar/sidecar.dart';
import 'package:flutter_utilities/flutter_utilities.dart';

class AvoidColorLiteral extends LintRule {
  AvoidColorLiteral(super.ref);

  @override
  String get code => 'avoid_color_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes
        .toDetectedLints(unit, this, message: 'Avoid color literal.');
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (element != null &&
        element.isSameAs(uri: 'dart.ui', className: 'Color')) {
      nodes.add(node);
    }
    super.visitInstanceCreationExpression(node);
  }
}
