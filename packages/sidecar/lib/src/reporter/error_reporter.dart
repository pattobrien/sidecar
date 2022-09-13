import '../models/models.dart';
import 'i_error_reporter.dart';

class ErrorReporter extends IErrorReporter {
  ErrorReporter(super.unit);

  @override
  List<DetectedLint> generateLints(LintRule rule) {
    final reportedNode = rule.computeAnalysisError(sourceUnit);

    return reportedNode.map((node) {
      final highlightedError = rule.computeLintHighlight(node);
      return node.copyWith(sourceSpan: highlightedError);
    }).toList();
  }
}
