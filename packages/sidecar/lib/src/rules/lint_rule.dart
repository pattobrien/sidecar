import 'package:analyzer/dart/analysis/results.dart';

import '../analyzer/ast/general_visitor.dart';
import '../analyzer/results/analysis_result.dart';
import 'base_rule.dart';
import 'lint_severity.dart';
import 'sidecar_ast_visitor.dart';

abstract class LintRule = BaseRule with LintMixin;

mixin LintMixin on BaseRule {
  LintSeverity get defaultSeverity => LintSeverity.info;
  String? get url => null;

  @override
  Future<List<LintAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      Future.value([]);
}

mixin LintVisitor on LintRule {
  SidecarAstVisitor get visitor;

  @override
  Future<List<LintAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    // final visitor = getVisitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.lints);
  }

  void registerNodeProcessors(NodeLintRegistry registry) {}
}

abstract class LintRuleWithVisitor = LintRule with LintVisitor;
