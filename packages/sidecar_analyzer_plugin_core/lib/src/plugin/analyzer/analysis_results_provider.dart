import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'analyzer.dart';

final analysisResultsProvider =
    FutureProvider.family<List<AnalysisResult>, AnalyzedFile>(
        (ref, file) async {
  final fileAnalyzerService = ref.watch(fileAnalyzerServiceProvider);
  final activatedRules = ref.watch(activatedRulesProvider(file.contextRoot));

  final unitResult = ref.watch(resolvedUnitProvider(file.path)).valueOrNull;

  return fileAnalyzerService.computeAnalysisResults(
    file,
    activatedRules,
    unitResult,
  );
});
