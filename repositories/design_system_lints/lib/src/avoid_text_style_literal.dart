import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:design_system_lints/src/constants.dart';
import 'package:flutter_analyzer_utils/painting.dart';
// import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

class AvoidTextStyleLiteral extends LintRule {
  @override
  String get code => 'avoid_text_style_literal';

  @override
  String get packageName => kDesignSystemPackageId;

  @override
  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.nodes);
  }
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (element == null) return;
    if (textStyleType.isAssignableFromType(element.returnType)) {
      reportAstNode(node, message: r'Avoid TextStyle literal.');
    }
    super.visitInstanceCreationExpression(node);
  }
}
