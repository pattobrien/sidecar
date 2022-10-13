import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../protocol/protocol.dart';
import '../analyzer.dart';

final analysisResultsProvider =
    FutureProvider.family<List<AnalysisResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);

    final activatedRules = ref.watch(filteredLintRulesProvider(file));
    final unitResult = ref.watch(resolvedUnitProvider(file)).valueOrNull;

    return fileService.computeAnalysisResults(
      file: file,
      activatedRules: activatedRules,
      unitResult: unitResult,
    );
  },
  dependencies: [
    filteredLintRulesProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);
