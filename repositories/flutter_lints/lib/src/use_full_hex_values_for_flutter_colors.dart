import 'dart:async';

import 'package:sidecar/sidecar.dart';

import 'package:flutter_utilities/flutter_utilities.dart';

const _desc =
    r'Prefer an 8-digit hexadecimal integer(0xFFFFFFFF) to instantiate Color.';

class UseFullHexValuesForFlutterColors extends LintRule {
  @override
  String get code => 'use_full_hex_values_for_flutter_colors';

  @override
  String get packageName => 'flutter_lints';

  @override
  String? get url =>
      'https://dart-lang.github.io/linter/lints/use_full_hex_values_for_flutter_colors.html';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this, message: _desc);
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (element != null &&
        element.isSameAs(uri: 'dart.ui', className: 'Color')) {
      final arguments = node.argumentList.arguments;
      if (arguments.isNotEmpty) {
        final argument = arguments.first;
        if (argument is IntegerLiteral) {
          final value = argument.literal.lexeme.toLowerCase();
          if (!value.startsWith('0x') || value.length != 10) {
            nodes.add(argument);
          }
        }
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}
