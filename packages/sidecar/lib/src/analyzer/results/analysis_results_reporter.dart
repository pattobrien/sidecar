import 'package:riverpod/riverpod.dart';

import '../context/analyzed_file.dart';
import '../server/log_delegate.dart';
import 'analysis_results_provider.dart';

final analysisResultsReporterProvider =
    FutureProvider.family.autoDispose<bool, AnalyzedFile>(
  (ref, file) async {
    final results = await ref.watch(lintResultsForFileProvider(file).future);
    ref.watch(logDelegateProvider).sidecarVerboseMessage(
        'analysisResultsReporterProvider = ${file.relativePath}');
    ref.watch(logDelegateProvider).analysisResults(file.path, results);
    return true;
  },
  name: 'analysisResultsReporterProvider',
  dependencies: [
    logDelegateProvider,
    analysisResultsForFileProvider,
    lintResultsForFileProvider,
  ],
);
