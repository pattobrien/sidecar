// ignore_for_file: use_setters_to_change_properties

import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:meta/meta.dart';
import 'package:source_span/source_span.dart';

import '../analyzer/context/analyzed_file.dart';
import '../configurations/configurations.dart';
import '../protocol/models/models.dart';
import '../utils/utils.dart';
import 'rules.dart';

// Visitors are unique for each
abstract class SidecarVisitor extends GeneralizingAstVisitor<void> {
  final Set<AnalysisResult> results = {};

  Map<dynamic, dynamic>? get configuration => _config?.configuration;

  late BaseRule _rule;
  late final AnalysisPackageConfiguration? _packageConfig;
  late final AnalysisConfiguration? _config;
  late final AnalyzedFileWithContext _file;

  @internal
  void init(
    BaseRule rule, {
    required AnalysisConfiguration? config,
    required AnalysisPackageConfiguration? packageConfig,
    required AnalyzedFileWithContext file,
  }) {
    _packageConfig = packageConfig;
    _config = config;
    _file = file;
    _rule = rule;
  }

  late ResolvedUnitResult _unit;

  void setUnit(ResolvedUnitResult unit) => _unit = unit;

  void dispose() => results.clear();

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

  void _reportSourceSpan(
    SourceSpan span,
    String message, {
    String? correction,
  }) {
    if (_rule is LintRule) {
      final config = _config as LintConfiguration?;
      final result = LintResult(
        rule: _rule.code,
        span: span,
        message: message,
        correction: correction,
        severity: config?.severity ?? (_rule as LintRule).defaultSeverity,
      );
      results.add(result);
    }
  }
}
