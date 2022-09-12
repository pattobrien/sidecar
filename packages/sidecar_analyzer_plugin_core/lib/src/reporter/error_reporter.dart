import 'package:sidecar/sidecar.dart';
import 'package:yaml/yaml.dart';

class ErrorReporter extends IErrorReporter {
  ErrorReporter(super.unit);

  @override
  void reportAstNode(AstNode? node, LintRule rule) {
    if (node != null) {
      final reportedLintError = DetectedLint(
        unit: sourceUnit,
        sourceSpan: node.toSourceSpan(sourceUnit),
        rule: rule,
      );

      final highlightedError = rule.computeLintHighlight(reportedLintError);

      detectedLints
          .add(reportedLintError.copyWith(sourceSpan: highlightedError));
    }
  }

  void reportYamlNode(YamlNode? node, LintRule rule) {
    if (node != null) {
      final reportedLintError =
          DetectedLint(unit: sourceUnit, sourceSpan: node.span, rule: rule);
      // final highlightedError = lint.computeLintHighlight(reportedLintError);
      detectedLints.add(reportedLintError);
    }
  }
}
