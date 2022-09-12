import 'package:sidecar/sidecar.dart';

import 'utils/utils.dart';

const _desc =
    r'Prefer an 8-digit hexadecimal integer(0xFFFFFFFF) to instantiate Color.';

class UseFullHexValuesForFlutterColors extends LintRule {
  UseFullHexValuesForFlutterColors(super.ref);

  @override
  String get code => 'use_full_hex_values_for_flutter_colors';

  @override
  String get packageName => 'flutter_lints';

  @override
  String get message => _desc;

  @override
  String? get url =>
      'https://dart-lang.github.io/linter/lints/use_full_hex_values_for_flutter_colors.html';

  @override
  List<DetectedLint> computeAnalysisError(ResolvedUnitResult unit) {
    final visitor = _Visitor(this, unit);
    unit.unit.accept(visitor);
    return visitor.detectedLints;
  }

  // @override
  // void registerNodeProcessors(NodeLintRegistry registry) {
  //   final visitor = _Visitor(this);
  //   registry.addInstanceCreationExpression(this, visitor);
  // }
}

class _Visitor extends SimpleAstVisitor {
  final LintRule rule;
  final ResolvedUnitResult unit;
  final List<DetectedLint> detectedLints = [];

  _Visitor(this.rule, this.unit);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var element = node.constructorName.staticElement;
    if (element != null &&
        element.isSameAs(
            uri: 'dart.ui', className: 'Color', constructorName: '')) {
      var arguments = node.argumentList.arguments;
      if (arguments.isNotEmpty) {
        var argument = arguments.first;
        if (argument is IntegerLiteral) {
          var value = argument.literal.lexeme.toLowerCase();
          if (!value.startsWith('0x') || value.length != 10) {
            // rule.reportAstNode(argument);
            final lint = DetectedLint.fromAstNode(node, unit, rule);
            detectedLints.add(lint);
          }
        }
      }
    }
  }
}
