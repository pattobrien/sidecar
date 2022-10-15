import 'package:riverpod/riverpod.dart';

import '../../services/services.dart';
import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/rules.dart';
import 'results.dart';

final analysisResultsForFileProvider =
    FutureProvider.family<List<AnalysisResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final activatedRules = ref.watch(lintRulesForFileProvider(file));

    final unit = await ref.watch(resolvedUnitProvider(file).future);

    final results = await fileService.computeAnalysisResults(
      file: file,
      activatedRules: activatedRules,
      unitResult: unit,
    );
    // TODO: make sending results a separate provider
    ref.watch(logDelegateProvider).analysisResults(file.path, results);
    return results;
  },
  name: 'analysisResultsForFileProvider',
  dependencies: [
    logDelegateProvider,
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);

final analysisResultsCompletedForContextProvider =
    Provider.family<bool, ActiveContextRoot>(
  (ref, root) {
    return root.typedAnalyzedFiles().every(
        (file) => ref.watch(analysisResultsForFileProvider(file)).hasValue);
  },
  name: 'analysisResultsCompletedForContextProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);

final analysisResultsForContextProvider =
    Provider.family<List<AnalysisResult>, ActiveContextRoot>(
  (ref, root) {
    final analyzedFiles = root.typedAnalyzedFiles();
    final results = analyzedFiles.map((file) =>
        ref.watch(analysisResultsForFileProvider(file)).valueOrNull ?? []);
    return results.expand((e) => e).toList();
  },
  name: 'analysisResultsForContextProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);
