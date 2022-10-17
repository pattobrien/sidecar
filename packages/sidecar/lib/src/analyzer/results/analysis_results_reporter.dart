import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';
import '../context/analyzed_file.dart';
import 'analysis_results_provider.dart';

final analysisResultsReporterProvider =
    FutureProvider.family<void, AnalyzedFile>(
  (ref, file) async {
    final results =
        await ref.watch(analysisResultsForFileProvider(file).future);
    ref.watch(logDelegateProvider).sidecarMessage(
        'analysisResultsReporterProvider = ${file.relativePath}');
    ref.watch(logDelegateProvider).analysisResults(file.path, results);
  },
  name: 'analysisResultsReporterProvider',
  dependencies: [
    logDelegateProvider,
    analysisResultsForFileProvider,
  ],
);
