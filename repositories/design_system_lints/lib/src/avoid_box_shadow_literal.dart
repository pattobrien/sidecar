import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
// import 'package:flutter_analyzer/flutter_analyzer.dart';
import 'package:flutter_analyzer/material.dart';
// import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';
// import 'package:sidecar_package_utilities/sidecar_package_utilities.dart';

import 'constants.dart';

class AvoidBoxShadowLiteral extends LintRule {
  @override
  String get code => 'avoid_box_shadow_literal';

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
    // if (element?.returnType.matchesType(boxShadow) ?? false) {
    //   reportAstNode(node, message: 'Avoid BoxShadow literal');
    // }
    // if (FlutterTypeChecker.isBoxShadow(element.returnType)) {
    //   reportAstNode(node, message: 'Avoid BoxShadow literal');
    // }
    if (boxShadowType.isAssignableFromType(element.returnType)) {
      reportAstNode(node, message: 'Avoid BoxShadow literal');
    }
    super.visitInstanceCreationExpression(node);
  }
}

// const boxShadow = SidecarType('BoxShadow', 'src/painting/box_shadow.dart');
