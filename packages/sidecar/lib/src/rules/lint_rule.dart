import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';

import '../analyzer/ast/general_visitor.dart';
import '../analyzer/results/analysis_result.dart';
import '../analyzer/results/edit_result.dart';
import 'analysis_source.dart';
import 'base_rule.dart';
import 'lint_severity.dart';
import 'sidecar_ast_visitor.dart';

abstract class LintRule = BaseRule with LintMixin;

mixin LintMixin on BaseRule {
  LintSeverity get defaultSeverity => LintSeverity.info;
  String? get url => null;

  //TODO: can we remove the future here?
  Future<List<LintResult>> generateAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      Future.value([]);

  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisSource source,
  ) =>
      Future.value(<EditResult>[]);
}

mixin LintVisitor on LintRule {
  SidecarAstVisitor Function() get visitorCreator;

  @override
  Future<List<LintResult>> generateAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = visitorCreator();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.lints);
  }

  void registerNodeProcessors(NodeLintRegistry registry) {}
}
