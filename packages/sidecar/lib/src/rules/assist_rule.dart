import 'package:analyzer/dart/analysis/results.dart';

import '../analyzer/results/analysis_result.dart';
import 'base_rule.dart';

abstract class AssistRule extends BaseRule {
  @override
  Future<List<AssistAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      Future.value([]);
}
