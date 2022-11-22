import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/ast/ast.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';

abstract class IFileAnalyzerService {
  //

}

class FileAnalyzerService {
  const FileAnalyzerService();

  Set<LintResult> visitLintResults({
    required ResolvedUnitResult? unitResult,
    required List<LintMixin> rules,
    required NodeRegistry registry,
  }) {
    final visitorRules = rules.whereType<BaseRuleVisitorMixin>().toList();
    registerVisitorsWithRegistry(visitorRules, registry);

    if (unitResult == null) return {};
    for (final visitor in rules) {
      visitor.setUnit(unitResult);
    }

    final visitor = RegisteredLintVisitor(registry);
    unitResult.unit.accept(visitor);
    return visitor.results;
  }

  void registerVisitorsWithRegistry(
    List<BaseRuleVisitorMixin> rules,
    NodeRegistry registry,
  ) {
    // ignore: prefer_iterable_wheretype
    final lintRules = rules.where((e) => e is LintMixin);
    lintRules.map((e) => e.initializeVisitor(registry));
  }

  // Future<List<LintResult>> computeLintResults({
  //   required AnalyzedFile file,
  //   required List<LintRule> rules,
  //   required UnitContext context,
  // }) async {
  //   //TODO: allow analysis of other file extensions
  //   if (!file.isDartFile) return [];

  //   final lintRulesBasicCompute = rules.whereType<Compute>();

  //   final results = await Future.wait(lintRulesBasicCompute.map((rule) async {
  //     try {
  //       final results = await rule.computeLints(context);
  //       return results;
  //     } catch (e, stackTrace) {
  //       logger.severe('LintRule Error', e, stackTrace);
  //       return Future.value(<LintResult>[]);
  //     }
  //   }));

  //   return results.expand((e) => e).toList()..sort();
  // }

  Iterable<LintResult> getAnalysisResultsAtOffset(
    Iterable<LintResult> analysisResults,
    QuickFixRequest request,
  ) {
    return analysisResults
        .where((res) => res.isWithinOffset(request.file.path, request.offset));
  }

  // Future<LintResultWithEdits> computeEditResultsForAnalysisResult({
  //   required UnitContext context,
  //   required LintResult analysisResult,
  //   required List<LintMixin> rules,
  // }) async {
  //   final code = analysisResult.rule;
  //   final rule = rules.firstWhere((r) => r.code == code);
  //   if (rule is! QuickFixMixin) return analysisResult.copyWithNoEdits();
  //   final edits = await analysisResult.editsComputer!(context);
  //   // final editResults = await rule.computeQuickFixes(analysisResult.span);
  //   return analysisResult.copyWithEdits(edits: edits);
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
  (ref) => const FileAnalyzerService(),
  name: 'fileAnalyzerServiceProvider',
  dependencies: const [],
);
