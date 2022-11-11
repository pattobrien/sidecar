// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../../protocol/protocol.dart';
// import '../../services/services.dart';
// import '../plugin/plugin.dart';
// import 'analysis_results_provider.dart';

// part 'quick_fix_results.g.dart';

// @riverpod
// Future<List<LintResultWithEdits>> requestQuickFixes(
//   RequestQuickFixesRef ref,
//   QuickFixRequest request,
// ) async {
//   final fileService = ref.watch(fileAnalyzerServiceProvider);
//   final rules = ref.watch(lintRulesForFileProvider(request.file));
//   final lintResults =
//       await ref.watch(lintResultsForFileProvider(request.file).future);
//   final filteredResults =
//       fileService.getAnalysisResultsAtOffset(lintResults, request);

//   return Future.wait(filteredResults.map((e) async {
//     final resultWithEdits =
//         await fileService.computeEditResultsForAnalysisResult(e, rules);
//     return resultWithEdits;
//   }));
// }

// // @riverpod
// // Future<List<LintResultWithEdits>> quickFixResultsForRoot(
// //   QuickFixResultsForRootRef ref,
// //   Context root,
// // ) async {
// //   final fileService = ref.watch(fileAnalyzerServiceProvider);
// //   final files = ref.watch(analyzedFilesForRootProvider(root));

// //   // wait for all analysis results to be computed before calculating quick fixes
// //   // await ref.watch(_isContextAnalyzingFilesProvider(root).future);
// //   final results = await ref.watch(requestQuickFixes(root).future);

// //   // final context = ref.watch(activeContextForRootProvider(root));
// //   final resultsWithEdits = await Future.wait(results.map((e) async {
// //     return fileService.computeEditResultsForAnalysisResult(e);
// //   }));

// //   return resultsWithEdits;
// // }

// // @riverpod
// // Future<void> awaitContextStillAnalyzing(
// //   AwaitContextStillAnalyzingRef ref,
// //   ActiveContextRoot root,
// // ) async {
// //   final allContextFiles = ref.watch(analyzedFilesForRootProvider(root));
// //   await Future.wait(allContextFiles.map(
// //     (analyzedFile) async =>
// //         ref.watch(analysisResultsForFileProvider(analyzedFile).future),
// //   ));
// // }
