import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../analyzer/results/results.dart';
import '../utils/utils.dart';
import 'analysis_source.dart';
import 'lint_rule.dart';

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void> {
  final List<LintResult> lints = [];
  late LintRule rule;
  late ResolvedUnitResult unit;
  // late List<SidecarAnnotatedNode> annotatedNodes;

  void initializeVisitor(
    LintRule rule,
    ResolvedUnitResult unit,
  ) {
    this.rule = rule;
    this.unit = unit;
  }

  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
  }) {
    final result = LintResult(
      rule: rule,
      source: AnalysisSource(
        path: unit.path,
        span: node.toSourceSpan(unit),
      ),
      message: message,
      correction: correction,
      severity: rule.defaultSeverity,
    );
    lints.add(result);
  }

  void reportToken(
    Token token, {
    required String message,
    String? correction,
  }) {
    final result = LintResult(
      rule: rule,
      source: AnalysisSource(
        path: unit.path,
        span: token.toSourceSpan(unit),
      ),
      message: message,
      correction: correction,
      severity: rule.defaultSeverity,
    );
    lints.add(result);
  }
}
