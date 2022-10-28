import 'package:analyzer/dart/analysis/results.dart';

import '../analyzer/results/analysis_result.dart';
import '../analyzer/results/edit_result.dart';
import 'analysis_source.dart';
import 'base_rule.dart';
import 'sidecar_ast_visitor.dart';

abstract class AssistRule extends BaseRule {
  Future<List<AssistResult>> filterResults(ResolvedUnitResult unit);

  Future<List<EditResult>> computeSourceChanges(AnalysisSource source);
}

mixin AssistVisitor on AssistRule {
  SidecarAssistVisitor Function() get visitorCreator;

  @override
  Future<List<AssistResult>> filterResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = visitorCreator();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.assists);
  }
}
