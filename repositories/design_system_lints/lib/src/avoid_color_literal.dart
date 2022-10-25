import 'dart:async';
// import 'dart:';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';
import 'package:flutter_utilities/flutter_utilities.dart';

import 'constants.dart';

class AvoidColorLiteral extends LintRule {
  @override
  String get code => 'avoid_color_literal';
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
    // final x = isNonFlutterMatch(element);
    // if (element != null &&
    //     element.isSameAs(sourcePath: 'dart.ui', className: 'Color')) {
    //   reportAstNode(node, message: 'Avoid color literal.');
    // }
    super.visitInstanceCreationExpression(node);
  }
}
