import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../analyzer/results/results.dart';
import '../configurations/configurations.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

final fileAnalyzerServiceProvider = Provider(
  (ref) => const FileAnalyzerService(),
  name: 'fileAnalyzerServiceProvider',
  dependencies: const [],
);

class FileAnalyzerService {
  const FileAnalyzerService();

  Future<List<LintResult>> computeLintResults({
    required AnalyzedFile file,
    required List<LintRule> rules,
    required ResolvedUnitResult? unitResult,
  }) async {
    //TODO: allow analysis of other file extensions
    if (file.isDartFile) {
      if (unitResult == null) return [];

      final results =
          await Future.wait(rules.map<Future<List<LintResult>>>((rule) async {
        // final ruleHasVisitor = rule is LintVisitor;
        try {
          // print('computeLintResults: ${file.path}');
          // TODO:
          // if (ruleHasVisitor) {
          final results = await rule.generateAnalysisResults(unitResult);
          return results.map(
            (result) {
              final config = rule.analysisConfiguration;
              return result.copyWith(
                severity: config is LintConfiguration
                    ? config.severity ?? rule.defaultSeverity
                    : throw UnimplementedError(),
              );
            },
          ).toList();
        } catch (e, stackTrace) {
          logger.severe('LintRule Error', e, stackTrace);
          return Future.value([]);
        }
      }));

      return results.expand((e) => e).toList()
        ..sort((a, b) => a.span.source.location.startLine
            .compareTo(b.span.source.location.startLine));
    } else {
      // TODO: handle non-Dart files
      return Future.value([]);
    }
  }

  Iterable<LintResult> getAnalysisResultsAtOffset(
    Iterable<LintResult> analysisResults,
    String path,
    int offset,
  ) {
    return analysisResults.where((res) => res.isWithinOffset(path, offset));
  }

  Future<LintResult> calculateEditResultsForAnalysisResult(
    ActiveContext context,
    LintResult analysisResult,
  ) async {
    final rule = analysisResult.rule;
    if (rule is! QuickFix) return analysisResult;

    final editResults = await rule.computeQuickFixes(analysisResult.span);
    return analysisResult.copyWith(edits: editResults);
  }

  Future<List<AssistResult>> computeAssistResults({
    required AnalyzedFile file,
    required List<AssistRule> rules,
    required ResolvedUnitResult? unitResult,
  }) async {
    //TODO: allow analysis of other file extensions
    if (file.isDartFile && unitResult != null) {
      final results =
          await Future.wait(rules.map<Future<List<AssistResult>>>((rule) async {
        try {
          return rule.filterResults(unitResult);
        } catch (e, stackTrace) {
          logger.severe('computeAssistResults', e, stackTrace);
          return Future.value([]);
        }
      }));
      return results.expand((e) => e).toList();
    } else {
      // TODO: handle non-Dart files
      return Future.value([]);
    }
  }

  List<AssistResult> getAssistResultsAtOffset(
    Iterable<AssistResult> analysisResults,
    QuickAssistRequest request,
  ) {
    return analysisResults
        .where((result) => result.isWithinOffset(request.path, request.offset))
        .toList();
  }

  Future<AssistResult> calculateAssistResultEdits(
    AssistResult result,
  ) async {
    final editResults = await result.rule.computeSourceChanges(result.span);
    return result.copyWith(edits: editResults);
  }
}
