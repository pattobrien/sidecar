import 'dart:async';

import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:sidecar/sidecar.dart';

class AvoidSizedBoxHeightWidthLiterals extends LintRule {
  @override
  String get code => 'avoid_sized_box_height_width_literals';

  @override
  String get packageName => 'project_lints';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this,
        message: 'Avoid using height or width literals in SizedBox widgets.');
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;

    final isSizedBox = FlutterTypeChecker.isSizedBox(element?.returnType);

    if (isSizedBox) {
      final args = node.argumentList.arguments
          .whereType<NamedExpression>()
          .where((e) =>
              e.name.label.name == 'width' || e.name.label.name == 'height');

      for (var arg in args) {
        final exp = arg.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          nodes.add(exp);
        }
        if (exp is PrefixedIdentifier) {
          //TODO: handle expressions like "SomeClass.staticInteger"
        }
        if (exp is SimpleIdentifier) {
          final element = exp.staticElement;
          //TODO: handle variables that are not declared
          // within the allowed design system spec file
          final x = element;
        }
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}
