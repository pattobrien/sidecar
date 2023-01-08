import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/ast/ast.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';

/// Service for generating Analysis Results for a particular file.
class FileAnalyzerServiceImpl {
  /// Service for generating Analysis Results for a particular file.
  const FileAnalyzerServiceImpl();

  Set<LintResult> visitLintResults(
    ResolvedUnitResult? unitResult,
    Set<Lint> rules,
    NodeRegistry registry,
  ) {
    if (unitResult == null) return {};
    for (final rule in rules) {
      rule.setUnitContext(unitResult);
    }

    final mainVisitor = RegisteredRuleVisitor(registry);
    unitResult.unit.accept(mainVisitor);
    final results = mainVisitor.lintResults;
    mainVisitor.clearResults();
    return results;
  }

  Set<SingleDataResult> visitDataResults(
    ResolvedUnitResult? unitResult,
    Set<Data> rules,
    NodeRegistry registry,
  ) {
    if (unitResult == null) return {};
    for (final rule in rules) {
      rule.setUnitContext(unitResult);
    }

    final mainVisitor = RegisteredRuleVisitor(registry);
    unitResult.unit.accept(mainVisitor);
    final results = mainVisitor.dataResults;
    mainVisitor.clearResults();
    return results;
  }

  Set<AssistResult> visitAssistFilters(
    ResolvedUnitResult? unitResult,
    Set<QuickAssist> rules,
    NodeRegistry registry,
  ) {
    if (unitResult == null) return {};
    for (final rule in rules) {
      rule.setUnitContext(unitResult);
    }

    final mainVisitor = RegisteredRuleVisitor(registry);
    unitResult.unit.accept(mainVisitor);
    final results = mainVisitor.assistResults;
    mainVisitor.clearResults();
    return results;
  }

  Iterable<LintResult> getAnalysisResultsAtOffset(
    Iterable<LintResult> analysisResults,
    QuickFixRequest request,
  ) {
    return analysisResults
        .where((res) => res.isWithinOffset(request.file.path, request.offset));
  }
}

/// Service for generating Analysis Results for a particular file.
final fileAnalyzerServiceProvider = Provider(
  (ref) => const FileAnalyzerServiceImpl(),
  name: 'fileAnalyzerServiceProvider',
  dependencies: const [],
);
