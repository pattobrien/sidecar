import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:design_system_lints/src/constants.dart';
import 'package:sidecar/sidecar.dart';

class AvoidSizedBoxHeightWidthLiterals extends LintRule with LintVisitor {
  @override
  String get code => 'avoid_sized_box_height_width_literals';

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
    final element = node.constructorName.staticElement;

    if (sizedBoxType.isAssignableFromType(element?.returnType)) {
      final args = node.argumentList.arguments
          .whereType<NamedExpression>()
          .where((e) =>
              e.name.label.name == 'width' || e.name.label.name == 'height');

      for (var arg in args) {
        final exp = arg.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          reportAstNode(
            exp,
            message:
                'Avoid using height or width literals in SizedBox widgets.',
            correction: 'Use design system spec instead.',
          );
        }
        if (exp is PrefixedIdentifier) {
          //TODO: handle expressions like "SomeClass.staticInteger"
        }
        if (exp is SimpleIdentifier) {
          // final element = exp.staticElement;
          // final x = element;

          //TODO: handle variables that are not declared
          // within the allowed design system spec file
        }
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}
