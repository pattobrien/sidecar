import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../protocol/models/models.dart';
import '../../utils/logger/logger.dart';
import '../context/analyzed_file.dart';
import '../server/log_delegate.dart';
import 'analysis_results_provider.dart';

part 'analysis_results_reporter.g.dart';

// final analysisResultsReporterProvider =
//     FutureProvider.family<void, AnalyzedFile>(
//   (ref, file) async {
//     final results = await ref.watch(lintResultsForFileProvider(file).future);
//     logger.finer('analysisResultsReporterProvider = ${file.relativePath}');
//     ref.watch(logDelegateProvider).analysisResults(file.path, results);
//     // return true;
//   },
//   name: 'analysisResultsReporterProvider',
//   dependencies: [
//     logDelegateProvider,
//     analysisResultsForFileProvider,
//     lintResultsForFileProvider,
//   ],
// );

@riverpod
Future<List<LintResult>> createAnalysisReport(
    CreateAnalysisReportRef ref, AnalyzedFile file) async {
  final results = await ref.watch(lintResultsForFileProvider(file).future);
  logger.finer('analysisResultsReporterProvider = ${file.relativePath}');
  // ref.watch(logDelegateProvider).analysisResults(file.path, results);
  return results;
}
