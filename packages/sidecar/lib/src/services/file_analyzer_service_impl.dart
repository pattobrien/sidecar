import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/analyzer_logger.dart';
import '../analyzer/ast/ast.dart';
import '../protocol/models/analysis_results.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';

/// Service for generating Analysis Results for a particular file.
class FileAnalyzerServiceImpl {
  /// Service for generating Analysis Results for a particular file.
  const FileAnalyzerServiceImpl(this.logger);

  final Logger logger;

  Set<AnalysisResult> visitResults(
    ResolvedUnitResult? unitResult,
    Set<BaseRule> rules,
    NodeRegistry registry,
  ) {
    if (unitResult == null) return {};
    for (final rule in rules) {
      rule.setUnitContext(unitResult);
    }

    final mainVisitor = RegisteredRuleVisitor(registry, logger);
    unitResult.unit.accept(mainVisitor);
    final results = mainVisitor.results;
    mainVisitor.clearResults();
    return results;
  }

  LintResults visitLintResults(
    ResolvedUnitResult? unitResult,
    Set<Lint> rules,
    NodeRegistry registry,
  ) {
    return LintResults(visitResults(unitResult, rules, registry)
        .whereType<LintResult>()
        .toSet());
  }

  Set<SingleDataResult> visitDataResults(
    ResolvedUnitResult? unitResult,
    Set<Data> rules,
    NodeRegistry registry,
  ) {
    return visitResults(unitResult, rules, registry)
        .whereType<SingleDataResult>()
        .toSet();
  }

  Set<AssistResult> visitAssistFilters(
    ResolvedUnitResult? unitResult,
    Set<QuickAssist> rules,
    NodeRegistry registry,
  ) {
    return visitResults(unitResult, rules, registry)
        .whereType<AssistResult>()
        .toSet();
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
  (ref) {
    final logger = ref.watch(loggerProvider);
    return FileAnalyzerServiceImpl(logger);
  },
  name: 'fileAnalyzerServiceProvider',
);
