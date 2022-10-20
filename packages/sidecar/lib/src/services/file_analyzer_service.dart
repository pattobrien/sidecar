import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../analyzer/results/results.dart';
import '../analyzer/server/log_delegate.dart';
import '../rules/rules.dart';
import '../utils/utils.dart';

final fileAnalyzerServiceProvider = Provider(
  (ref) {
    return FileAnalyzerService(ref);
  },
  name: 'fileAnalyzerServiceProvider',
  dependencies: [
    logDelegateProvider,
  ],
);

class FileAnalyzerService {
  const FileAnalyzerService(this.ref);

  final Ref ref;

  void _log(String message) =>
      ref.read(logDelegateProvider).sidecarVerboseMessage(message);

  void _logError(Object e, StackTrace stackTrace) =>
      ref.read(logDelegateProvider).sidecarError(e, stackTrace);

  Future<List<AnalysisResult>> computeAnalysisResults({
    required AnalyzedFile file,
    required List<SidecarBase> activatedRules,
    required ResolvedUnitResult? unitResult,
  }) async {
    //TODO: allow analysis of other file extensions
    if (file.isDartFile) {
      if (unitResult == null) return [];

      final results = await Future.wait(
          activatedRules.map<Future<List<DartAnalysisResult>>>((rule) {
        try {
          return rule.computeDartAnalysisResults(unitResult);
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

  Iterable<AnalysisResult> getAnalysisResultsAtOffset(
    Iterable<AnalysisResult> analysisResults,
    String path,
    int offset,
  ) {
    return analysisResults.where((analysisResult) =>
        analysisResult.isWithinOffset(path, offset) &&
        analysisResult.rule is LintRule);
  }

  Future<Iterable<EditResult>> calculateEditResultsForAnalysisResult(
    ActiveContext context,
    AnalysisResult analysisResult,
  ) async {
    return analysisResult.rule
        .computeSourceChanges(context.currentSession, analysisResult);
  }

  Future<Iterable<EditResult>> calculateAssistEdits(
    ActiveContext context,
    AnalysisResult analysisResult,
  ) async {
    return analysisResult.rule
        .computeSourceChanges(context.currentSession, analysisResult);
  }

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
