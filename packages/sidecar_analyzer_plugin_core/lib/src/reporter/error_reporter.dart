import 'package:sidecar/sidecar.dart';

class ErrorReporter extends IErrorReporter {
  ErrorReporter(super.unit);

  @override
  void reportAstNode(AstNode? node, LintRule lint) {
    if (node != null) {
      final reportedLintError =
          DetectedLint(unit: sourceUnit, node: node, rule: lint);
      final highlightedError = lint.computeLintHighlight(reportedLintError);
      detectedLints.add(highlightedError);
    }
  }
}
