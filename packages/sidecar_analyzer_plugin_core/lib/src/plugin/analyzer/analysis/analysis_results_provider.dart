import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';
import '../analyzer.dart';

final analysisResultsForFileProvider =
    FutureProvider.family<List<AnalysisResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final activatedRules = ref.watch(lintRulesForFileProvider(file));

    final unitResult = await ref.watch(resolvedUnitProvider(file).future);

    final results = await fileService.computeAnalysisResults(
      file: file,
      activatedRules: activatedRules,
      unitResult: unitResult,
    );
    ref.watch(logDelegateProvider).sidecarMessage(
        'analysis complete w/ ${results.length} results || ${file.path}');

    ref.watch(logDelegateProvider).analysisResults(file.path, results);
    return results;
  },
  name: 'analysisResultsProvider',
  dependencies: [
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);

final analysisResultsCompletedForContextProvider =
    Provider.family<bool, ActiveContextRoot>(
  (ref, root) {
    final allFiles = root.typedAnalyzedFiles();
    return allFiles
        .every((e) => ref.watch(analysisResultsForFileProvider(e)).hasValue);
  },
  name: 'analysisResultsCompletedForContextProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);

final analysisResultsForContextProvider =
    Provider.family<List<AnalysisResult>, ActiveContextRoot>(
  (ref, root) {
    final allFiles = root.typedAnalyzedFiles();
    final values = allFiles.map(
        (e) => ref.watch(analysisResultsForFileProvider(e)).valueOrNull ?? []);
    return values.expand((element) => element).toList();
  },
  name: 'analysisResultsForContextProvider',
  dependencies: [analysisResultsForFileProvider],
);
