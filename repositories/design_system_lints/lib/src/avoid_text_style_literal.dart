import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/builder.dart';

class AvoidTextStyleLiteral extends LintRule {
  @override
  String get code => 'avoid_text_style_literal';

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
    if (FlutterTypeChecker.isTextStyle(element?.returnType)) {
      reportAstNode(node, message: r'Avoid TextStyle literal.');
    }
    super.visitInstanceCreationExpression(node);
  }
}
