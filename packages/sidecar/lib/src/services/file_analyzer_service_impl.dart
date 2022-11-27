import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/ast/ast.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';

/// Service for generating Analysis Results for a particular file.
class FileAnalyzerServiceImpl {
  /// Service for generating Analysis Results for a particular file.
  const FileAnalyzerServiceImpl();

  Set<LintResult> visitLintResults({
    required ResolvedUnitResult? unitResult,
    required Set<Lint> rules,
    required NodeRegistry registry,
  }) {
    if (unitResult == null) return {};
    for (final rule in rules) {
      rule.setUnitContext(unitResult);
    }

    final mainVisitor = RegisteredLintVisitor(registry);
    unitResult.unit.accept(mainVisitor);
    final results = mainVisitor.lintResults;
    return results;
  }

  Set<AssistFilterResult> visitAssistFilters({
    required ResolvedUnitResult? unitResult,
    required Set<QuickAssist> rules,
    required NodeRegistry registry,
  }) {
    if (unitResult == null) return {};
    for (final rule in rules) {
      rule.setUnitContext(unitResult);
    }

    final mainVisitor = RegisteredLintVisitor(registry);
    unitResult.unit.accept(mainVisitor);
    final results = mainVisitor.assistResults;
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
