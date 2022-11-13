import 'package:riverpod/riverpod.dart';

import '../analyzer/ast/ast.dart';
import '../analyzer/context/context.dart';
import '../analyzer/context/unit_context.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';

class FileAnalyzerService {
  const FileAnalyzerService(this.ref);

  final Ref ref;

  Set<LintResult> visitLintResults({
    required AnalyzedFile file,
    required UnitContext context,
    required List<LintVisitor> rules,
    required NodeRegistry registry,
  }) {
    rules.map((e) => e.initializeVisitor(registry));
    final visitor = RegisteredLintVisitor(registry);
    context.currentUnit.accept(visitor);
    return visitor.results;
  }

  Future<List<LintResult>> computeLintResults({
    required AnalyzedFile file,
    required List<LintRule> rules,
    required UnitContext context,
  }) async {
    //TODO: allow analysis of other file extensions
    if (!file.isDartFile) return [];

    final lintRulesBasicCompute = rules.whereType<Compute>();

    final results = await Future.wait(lintRulesBasicCompute.map((rule) async {
      try {
        final results = await rule.computeLints(context);
        return results;
      } catch (e, stackTrace) {
        logger.severe('LintRule Error', e, stackTrace);
        return Future.value(<LintResult>[]);
      }
    }));

    return results.expand((e) => e).toList()..sort();
  }

  Iterable<LintResult> getAnalysisResultsAtOffset(
    Iterable<LintResult> analysisResults,
    QuickFixRequest request,
  ) {
    return analysisResults
        .where((res) => res.isWithinOffset(request.file.path, request.offset));
  }

  // Future<LintResultWithEdits> computeEditResultsForAnalysisResult(
  //   LintResult analysisResult,
  //   List<LintRule> rules,
  // ) async {
  //   final code = analysisResult.rule;
  //   final rule = rules.firstWhere((r) => r.code == code);
  //   if (rule is! QuickFix) return analysisResult.copyWithNoEdits();
  //   final editResults = await rule.computeQuickFixes(analysisResult.span);
  //   return analysisResult.copyWithEdits(edits: editResults);
  // }

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
  //   AssistRequest request,
  // ) {
  //   return analysisResults
  //       .where((res) => res.isWithinOffset(request.file.path, request.offset))
  //       .toList();
  // }

  // Future<AssistResult> calculateAssistResultEdits(
  //   AssistResult result, {
  //   required List<AssistRule> rules,
  //   required AnalyzedFile file,
  // }) async {
  //   // final editResults = await result.code.computeSourceChanges(result.span);
  //   // return result.copyWith(edits: editResults);
  //   final code = result.code;
  //   final rule = rules.firstWhere((element) => element.code == code);
  //   final editResults = await rule.computeSourceChanges(result.span);
  //   return result.copyWith(edits: editResults);
  // }
}

final fileAnalyzerServiceProvider = Provider(
  FileAnalyzerService.new,
  name: 'fileAnalyzerServiceProvider',
  dependencies: const [],
);
