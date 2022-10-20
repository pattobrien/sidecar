import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidEdgeInsetsLiteral extends LintRule {
  @override
  String get code => 'avoid_edge_insets_literal';

  @override
  String get packageName => kDesignSystemPackageId;

  @override
  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = AvoidEdgeInsetsLiteralVisitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.nodes);
  }
}

class AvoidEdgeInsetsLiteralVisitor extends SidecarAstVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final type = node.constructorName.staticElement?.returnType;

    if (FlutterTypeChecker.isEdgeInsets(type)) {
      final args = node.argumentList.arguments
          .whereType<NamedExpression>()
          .where((e) =>
              e.name.label.name == 'horizontal' ||
              e.name.label.name == 'vertical');

      for (var arg in args) {
        final exp = arg.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          reportAstNode(
            exp,
            message: 'Avoid edge insets literal.',
          );
        }
        // e.g. CustomTheme.smallInsets()
        // if (exp is PrefixedIdentifier) {
        //   //TODO: dart question: should we be going from AST => Element => AST
        //   //to do this computation, or is there a way to do this via ASTs only?
        //   final ele = exp.staticElement!.declaration;
        //   if (ele is PropertyAccessorElement) {
        //     // final y = ele.declaration.constantInitializer;
        //     final x = ele.variable.isConstantEvaluated;
        //     final y = x;
        //   }
        //   if (ele is ParameterElement) {
        //     final x = ele;
        //   }
        //   final element = exp.staticType?.element2;
        //   final node = ele;
        //   // final x = ele.canonicalElement;
        //   //   final x =
        // }
        // // e.g. smallInsets()
        // if (exp is SimpleIdentifier) {
        //   final element = exp.staticType?.element2;
        //   // final x = element;

        // }
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}
