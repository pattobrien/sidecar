import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../analyzer/results/results.dart';
import '../analyzer/server/log_delegate.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';
import '../utils/utils.dart';

final fileAnalyzerServiceProvider = Provider(
  FileAnalyzerService.new,
  name: 'fileAnalyzerServiceProvider',
  dependencies: [
    logDelegateProvider,
  ],
);

class FileAnalyzerService {
  const FileAnalyzerService(Ref ref) : _ref = ref;
  final Ref _ref;

  void _logError(Object e, StackTrace stackTrace) =>
      _ref.read(logDelegateProvider).sidecarError(e, stackTrace);

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
          return results
              .map((result) => result.copyWith(
                    severity: rule.analysisConfiguration.map(
                      lint: (lintConfig) =>
                          lintConfig.severity ?? rule.defaultSeverity,
                      assist: (assistConfig) => throw UnimplementedError(),
                    ),
                  ))
              .toList();
          // } else {
          //   final results = await rule.generateAnalysisResults(unitResult);
          //   return results
          //       .map((result) => result.copyWith(
          //             severity: rule.analysisConfiguration.map(
          //               lint: (lintConfig) =>
          //                   lintConfig.severity ?? rule.defaultSeverity,
          //               assist: (assistConfig) => throw UnimplementedError(),
          //             ),
          //           ))
          //       .toList();
          // }
        } catch (e, stackTrace) {
          _logError('LintRule Error: ${e.toString()}', stackTrace);
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
  ) =>
      analysisResults.where((result) => result.isWithinOffset(path, offset));

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
    if (file.isDartFile) {
      if (unitResult == null) return [];
      final results =
          await Future.wait(rules.map<Future<List<AssistResult>>>((rule) async {
        try {
          final assistResults = await rule.filterResults(unitResult);
          return assistResults;
        } catch (e, stackTrace) {
          _logError('LintRule Error: ${e.toString()}', stackTrace);
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
        .where(
          (result) => result.isWithinOffset(request.file.path, request.offset),
        )
        .toList();
  }

  Future<AssistResult> calculateAssistResultEdits(
    AssistResult result,
  ) async {
    final rule = result.rule;
    final editResults = await rule.computeSourceChanges(result.span);
    return result.copyWith(edits: editResults);
  }
}
