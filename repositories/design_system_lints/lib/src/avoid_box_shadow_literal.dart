import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidBoxShadowLiteral extends LintRule {
  @override
  String get code => 'avoid_box_shadow_literal';

  @override
  String get packageName => kDesignSystemPackageId;

  @override
  String? get url => kUrl;

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
    if (boxShadowType.isAssignableFromType(element.returnType)) {
      reportAstNode(node, message: 'Avoid BoxShadow literal');
    }
    super.visitInstanceCreationExpression(node);
  }
}

// const boxShadow = SidecarType('BoxShadow', 'src/painting/box_shadow.dart');
