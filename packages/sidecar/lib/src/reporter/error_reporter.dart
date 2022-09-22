import 'package:analyzer/dart/analysis/analysis_context.dart';

import '../../sidecar.dart';
import '../models/models.dart';
import 'i_error_reporter.dart';

class ErrorReporter extends IErrorReporter {
  ErrorReporter(super.sourcePath);

  Future<List<DetectedLint>> generateDartLints(
    ResolvedUnitResult unit,
    LintRule rule,
  ) async {
    final reportedNode = await rule.computeDartAnalysisError(unit);

    return reportedNode.map((node) {
      final highlightedError = rule.computeLintHighlight(node);
      return node.copyWith(sourceSpan: highlightedError);
    }).toList();
  }

  @override
  Future<List<DetectedLint>> generateLints(
    AnalysisContext context,
    LintRule rule,
  ) async {
    final reportedNode = await rule.computeAnalysisError(context, sourcePath);

    return reportedNode.map((node) {
      final highlightedError = rule.computeLintHighlight(node);
      return node.copyWith(sourceSpan: highlightedError);
    }).toList();
  }
}
