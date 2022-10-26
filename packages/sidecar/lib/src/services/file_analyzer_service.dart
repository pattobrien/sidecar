import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../analyzer/results/results.dart';
import '../analyzer/server/log_delegate.dart';
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

  Future<List<LintAnalysisResult>> computeLintResults({
    required AnalyzedFile file,
    required List<LintRule> rules,
    required ResolvedUnitResult? unitResult,
  }) async {
    //TODO: allow analysis of other file extensions
    if (file.isDartFile) {
      if (unitResult == null) return [];

      final results = await Future.wait(
          rules.map<Future<List<LintAnalysisResult>>>((rule) async {
        try {
          final results = await rule.computeDartAnalysisResults(unitResult);
          return results
              .map((result) => result.copyWith(
                    severity: rule.analysisConfiguration.map(
                      lint: (lintConfig) =>
                          lintConfig.severity ?? rule.defaultSeverity,
                      assist: (assistConfig) => throw UnimplementedError(),
                    ),
                  ))
              .toList();
        } catch (e, stackTrace) {
          _logError('LintRule Error: ${e.toString()}', stackTrace);
          return Future.value([]);
        }
      }));

      return results.expand((e) => e).toList()
        ..sort((a, b) => a.sourceSpan.location.startLine
            .compareTo(b.sourceSpan.location.startLine));
    } else {
      // TODO: handle non-Dart files
      return Future.value([]);
    }
  }

  Iterable<LintAnalysisResult> getAnalysisResultsAtOffset(
    Iterable<LintAnalysisResult> analysisResults,
    String path,
    int offset,
  ) =>
      analysisResults.where((result) => result.isWithinOffset(path, offset));

  // Future<Iterable<EditResult>> calculateEditResultsForAnalysisResult(
  //   ActiveContext context,
  //   AnalysisResult analysisResult,
  // ) async {
  //   return analysisResult.rule
  //       .computeSourceChanges(context.currentSession, analysisResult);
  // }

  // Future<Iterable<EditResult>> calculateAssistEdits(
  //   ActiveContext context,
  //   AnalysisResult analysisResult,
  // ) async {
  //   return analysisResult.rule
  //       .computeSourceChanges(context.currentSession, analysisResult);
  // }

  // Future<Iterable<EditResult>> calculateEditResults(
  //   ActiveContext context,
  //   Iterable<AnalysisResult> analysisResults,
  //   String path,
  //   int offset,
  // ) async {
  //   final results = await Future.wait<List<EditResult>>(analysisResults
  //       .map((e) => e.rule.computeSourceChanges(context.currentSession, e)));
  //   return results.expand((element) => element);
  // }
}
