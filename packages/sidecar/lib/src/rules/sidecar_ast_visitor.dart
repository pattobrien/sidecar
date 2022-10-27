import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/results/results.dart';
import '../utils/utils.dart';
import 'analysis_source.dart';
import 'lint_rule.dart';

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void> {
  final List<LintResult> lints = [];
  late LintRule rule;
  late ResolvedUnitResult unit;
  // late final Ref _ref;

  @internal
  void initializeVisitor(
    LintRule rule,
    ResolvedUnitResult unit,
    // Ref ref,
  ) {
    this.rule = rule;
    this.unit = unit;
    // _ref = ref;
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
