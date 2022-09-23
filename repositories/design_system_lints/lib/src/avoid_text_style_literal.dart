import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

class AvoidTextStyleLiteral extends LintRule {
  AvoidTextStyleLiteral(super.ref);

  @override
  String get code => 'avoid_text_style_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes
        .toDetectedLints(unit, this, message: r'Avoid TextStyle literal.');
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (FlutterTypeChecker.isTextStyle(element?.returnType)) {
      nodes.add(node);
    }
    super.visitInstanceCreationExpression(node);
  }
}
