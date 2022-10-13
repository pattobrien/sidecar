import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import 'analyzed_file.dart';

final fileAnalyzerServiceProvider =
    Provider((ref) => const FileAnalyzerService());

class FileAnalyzerService {
  const FileAnalyzerService();

  Future<List<AnalysisResult>> computeAnalysisResults(
    AnalyzedFile file,
    List<SidecarBase> activatedRules,
    ResolvedUnitResult? unitResult,
  ) async {
    if (file.path == file.contextRoot.optionsFile?.path) {
      //TODO: reimplement analysis file errors

      // return ref.read(projectConfigurationAnalysisErrorProvider(root).future);
      return [];
      // throw UnimplementedError();
    }
    //TODO: allow analysis of other file extensions
    if (file.isDartFile) {
      if (unitResult == null) return [];

      final results = await Future.wait(activatedRules
          .whereType<LintRule>()
          .map<Future<List<DartAnalysisResult>>>((rule) {
        try {
          return rule.computeDartAnalysisResults(unitResult);
        } catch (e, stackTrace) {
          // delegate.sidecarError('LintRule Error: ${e.toString()}', stackTrace);
          return Future.value([]);
        }
      }));

      final sortedResults = results.expand((element) => element).toList()
        ..sort((a, b) => a.sourceSpan.location.startLine
            .compareTo(b.sourceSpan.location.startLine));
      return sortedResults;
    } else {
      // TODO: handle non-Dart files
      return Future.value([]);
    }
  }

  Iterable<AnalysisResult> calculateAnalysisResultsAtOffset(
    Iterable<AnalysisResult> analysisResults,
    String path,
    int offset,
  ) {
    return analysisResults.where((analysisResult) {
      return analysisResult.isWithinOffset(path, offset) &&
          analysisResult.rule is LintRule;
    });
  }

  // Future<Iterable<EditResult>> calculateEditResults(
  //   Iterable<AnalysisResult> analysisResults,
  //   String path,
  //   int offset,
  // ) async {
  //   final results = await Future.wait<List<EditResult>>(analysisResults
  //       .map((e) => e.rule.computeSourceChanges(context.currentSession, e)));
  //   return results.expand((element) => element);
  // }

}
