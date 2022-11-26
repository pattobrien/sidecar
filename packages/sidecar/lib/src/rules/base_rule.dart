// ignore_for_file: use_setters_to_change_properties

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:meta/meta.dart';
import 'package:source_span/source_span.dart';

import '../analyzer/ast/ast.dart';
import '../analyzer/ast/general_visitor.dart';
import '../configurations/sidecar_spec/sidecar_spec.dart';
import '../protocol/protocol.dart';
import '../utils/utils.dart';
import 'lint_severity.dart';
import 'rules.dart';

mixin BaseRule {
  final Set<AnalysisResult> results = {};
  late ResolvedUnitResult _unit;

  ResolvedUnitResult get unit => _unit;

  void setUnit(ResolvedUnitResult unit) => _unit = unit;

  RuleCode get code;
  List<Glob>? get includes => null;
  List<Glob>? get excludes => null;

  SidecarSpec? sidecarSpec;

  @internal
  void refresh({
    required SidecarSpec sidecarSpec,
  }) {
    this.sidecarSpec = sidecarSpec;
    results.clear();
  }

  void _reportSourceSpan(
    SourceSpan span,
    String message, {
    String? correction,
    EditsComputer? editsComputer,
  }) {
    if (this is Lint) {
      final thisConfig =
          sidecarSpec?.getConfigurationForCode(code) as LintOptions?;
      final result = LintResult(
        rule: code,
        span: span,
        message: message,
        correction: correction,
        severity: thisConfig?.severity ?? (this as Lint).defaultSeverity,
        editsComputer: editsComputer,
      );
      results.add(result);
    }
  }
}

mixin BaseRuleVisitorMixin on BaseRule {
  void initializeVisitor(NodeRegistry registry);
}

mixin QuickAssist on BaseRule {
  void reportAssistForNode(
    AstNode node, {
    required String message,
    EditsComputer? editsComputer,
  }) =>
      _reportSourceSpan(node.toSourceSpan(_unit), message,
          editsComputer: editsComputer);

  void reportAssistForToken(
    Token token, {
    required String message,
    EditsComputer? editsComputer,
  }) =>
      _reportSourceSpan(token.toSourceSpan(_unit), message,
          editsComputer: editsComputer);
}

mixin Lint on BaseRule {
  @override
  LintCode get code;
  LintSeverity get defaultSeverity => LintSeverity.info;

  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
  }) =>
      _reportSourceSpan(node.toSourceSpan(_unit), message,
          correction: correction);

  void reportToken(
    Token token, {
    required String message,
    String? correction,
  }) =>
      _reportSourceSpan(token.toSourceSpan(_unit), message,
          correction: correction);
}

mixin QuickFix on Lint {
  @override
  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      _reportSourceSpan(node.toSourceSpan(_unit), message,
          correction: correction, editsComputer: editsComputer);

  @override
  void reportToken(
    Token token, {
    required String message,
    String? correction,
    EditsComputer? editsComputer,
  }) =>
      _reportSourceSpan(token.toSourceSpan(_unit), message,
          correction: correction, editsComputer: editsComputer);
}
