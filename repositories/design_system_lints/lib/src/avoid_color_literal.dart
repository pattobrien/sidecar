import 'dart:async';

import 'package:sidecar/builder.dart';
import 'package:flutter_utilities/flutter_utilities.dart';

class AvoidColorLiteral extends LintRule {
  @override
  String get code => 'avoid_color_literal';

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
    final element = node.constructorName.staticElement;
    if (element != null &&
        element.isSameAs(uri: 'dart.ui', className: 'Color')) {
      reportAstNode(node, message: 'Avoid color literal.');
    }
    super.visitInstanceCreationExpression(node);
  }
}
