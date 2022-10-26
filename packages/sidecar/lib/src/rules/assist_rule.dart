import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';

import '../analyzer/results/analysis_result.dart';
import '../analyzer/results/edit_result.dart';
import 'analysis_source.dart';
import 'base_rule.dart';

abstract class AssistRule extends BaseRule {
  Future<List<AssistAnalysisResult>> filterResults(
    ResolvedUnitResult unit,
  ) =>
      Future.value([]);

  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisSource source,
  ) =>
      Future.value(<EditResult>[]);
}
