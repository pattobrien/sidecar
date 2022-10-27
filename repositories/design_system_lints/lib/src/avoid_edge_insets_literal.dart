import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidEdgeInsetsLiteral extends LintRule with LintVisitor {
  @override
  String get code => 'avoid_edge_insets_literal';

  @override
  String get packageName => kDesignSystemPackageId;

  @override
  String get url => kUrl;

  @override
  SidecarAstVisitor Function() get visitorCreator => _Visitor.new;
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final type = node.constructorName.staticElement?.returnType;
    if (edgeInsetsType.isAssignableFromType(type)) {
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
            correction: 'Use design system spec instead.',
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
