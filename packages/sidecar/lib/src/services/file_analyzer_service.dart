import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../analyzer/results/results.dart';
import '../configurations/configurations.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';

class FileAnalyzerService {
  const FileAnalyzerService();

  Future<List<LintResult>> computeLintResults({
    required AnalyzedFile file,
    required List<LintRule> rules,
    required ResolvedUnitResult? unitResult,
  }) async {
    //TODO: allow analysis of other file extensions
    if (!file.isDartFile) return [];
    if (unitResult == null) return [];

    final results = await Future.wait(rules.map((rule) async {
      try {
        final results = await rule.generateAnalysisResults(unitResult);
        return results.map(
          (result) {
            final config = rule.analysisConfiguration as LintConfiguration;
            return result.copyWith(
                severity: config.severity ?? rule.defaultSeverity);
          },
        ).toList();
      } catch (e, stackTrace) {
        logger.severe('LintRule Error', e, stackTrace);
        return Future.value(<LintResult>[]);
      }
    }));

    return results.expand((e) => e).toList()..sort();
  }

  Iterable<LintResult> getAnalysisResultsAtOffset(
    Iterable<LintResult> analysisResults,
    String path,
    int offset,
  ) {
    return analysisResults.where((res) => res.isWithinOffset(path, offset));
  }

  Future<LintResultWithEdits> computeEditResultsForAnalysisResult(
    ActiveContext context,
    LintResult analysisResult,
    List<LintRule> rules,
  ) async {
    final code = analysisResult.rule;
    final rule = rules.firstWhere((element) => element.ruleCode == code);
    if (rule is! QuickFix) return analysisResult.copyWithNoEdits();
    final editResults = await rule.computeQuickFixes(analysisResult.span);
    return analysisResult.copyWithEdits(edits: editResults);
  }

  // Future<List<AssistResult>> computeAssistResults({
  //   required AnalyzedFile file,
  //   required List<AssistRule> rules,
  //   required ResolvedUnitResult? unitResult,
  // }) async {
  //   //TODO: allow analysis of other file extensions
  //   if (!file.isDartFile || unitResult == null) return [];

  //   final results =
  //       await Future.wait(rules.map<Future<List<AssistResult>>>((rule) async {
  //     try {
  //       return rule.filterResults(unitResult);
  //     } catch (e, stackTrace) {
  //       logger.severe('computeAssistResults', e, stackTrace);
  //       return Future.value([]);
  //     }
  //   }));
  //   return results.expand((e) => e).toList()..sort();
  // }

  // List<AssistResult> getAssistResultsAtOffset(
  //   Iterable<AssistResult> analysisResults,
  //   QuickAssistRequest request,
  // ) {
  //   return analysisResults
  //       .where((result) => result.isWithinOffset(request.path, request.offset))
  //       .toList();
  // }

//   Future<AssistResult> calculateAssistResultEdits(
//     AssistResult result,
//   ) async {
//     final editResults = await result.rule.computeSourceChanges(result.span);
//     return result.copyWith(edits: editResults);
//   }
}

final fileAnalyzerServiceProvider = Provider(
  (ref) => const FileAnalyzerService(),
  name: 'fileAnalyzerServiceProvider',
  dependencies: const [],
);
