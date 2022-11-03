import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:meta/meta.dart';

import '../protocol/protocol.dart';
import '../utils/utils.dart';
import 'rules.dart';

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void> {
  final List<LintResult> lints = [];
  late LintRule rule;
  late ResolvedUnitResult unit;

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
      rule: rule.ruleCode,
      span: node.toSourceSpan(unit),

      message: message,
      correction: correction,
      // TODO: when do we handle which severity is used? (default vs configured)
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
      rule: rule.ruleCode,
      span: token.toSourceSpan(unit),
      message: message,
      correction: correction,
      severity: rule.defaultSeverity,
    );
    lints.add(result);
  }
}

abstract class SidecarAssistVisitor extends GeneralizingAstVisitor<void> {
  final List<AssistResult> assists = [];
  late AssistRule rule;
  late ResolvedUnitResult unit;

  @internal
  void initializeVisitor(
    AssistRule rule,
    ResolvedUnitResult unit,
  ) {
    this.rule = rule;
    this.unit = unit;
  }

  // void reportAstNode(AstNode node) {
  //   final result = AssistResult(
  //     code: rule.ruleCode,
  //     span: EditResult(
  //       path: unit.path,
  //       source: node.toSourceSpan(unit),
  //     ),
  //   );
  //   assists.add(result);
  // }

  // void reportToken(Token token) {
  //   final result = AssistResult(
  //     code: rule.ruleCode,
  //     span: AnalysisSourceSpan(
  //       path: unit.path,
  //       source: token.toSourceSpan(unit),
  //     ),
  //   );
  //   assists.add(result);
  // }
}
