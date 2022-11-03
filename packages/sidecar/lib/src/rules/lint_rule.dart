import 'package:analyzer/dart/analysis/results.dart';
import 'package:source_span/source_span.dart';

import '../analyzer/ast/general_visitor.dart';
import '../protocol/models/models.dart';
import '../protocol/protocol.dart';
import 'base_rule.dart';
import 'lint_severity.dart';
import 'sidecar_ast_visitor.dart';

abstract class LintRule = BaseRule with Lint;

mixin Lint on BaseRule {
  LintSeverity get defaultSeverity => LintSeverity.info;
  String? get url => null;

  //TODO: can we remove the future here?
  Future<List<LintResult>> generateAnalysisResults(
    ResolvedUnitResult unit,
  ) =>
      Future.value([]);
}

mixin QuickFix on LintRule {
  Future<List<EditResult>> computeQuickFixes(SourceSpan source);
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
