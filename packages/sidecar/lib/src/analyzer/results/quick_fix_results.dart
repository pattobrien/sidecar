// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../../protocol/protocol.dart';
// import '../../services/services.dart';
// import '../context/context.dart';
// import '../plugin/plugin.dart';
// import '../plugin/sidecar_analyzer.dart';
// import 'analysis_results_provider.dart';

// part 'quick_fix_results.g.dart';

// @riverpod
// Future<List<LintResultWithEdits>> requestQuickFixes(
//   RequestQuickFixesRef ref,
//   SidecarAnalyzer analyzer,
//   QuickFixRequest request,
// ) async {
//   final fileService = ref.watch(fileAnalyzerServiceProvider);
//   final context = ref.watch(activeContextForRootProvider(request.file.root));
//   final lintResults =
//       await ref.watch(lintResultsForFileProvider(request.filePath).future);

//   final analysisResultsForOffset = lintResults.where(
//       (element) => element.isWithinOffset(request.filePath, request.offset));
//   return Future.wait(analysisResultsForOffset.map((e) async {
//     final resultWithEdits =
//         await fileService.computeEditResultsForAnalysisResult(context, e);
//     return resultWithEdits;
//   }));
// }

// @riverpod
// Future<List<LintResultWithEdits>> quickFixResultsForRoot(
//   QuickFixResultsForRootRef ref,
//   ActiveContextRoot root,
// ) async {
//   final fileService = ref.watch(fileAnalyzerServiceProvider);

//   // wait for all analysis results to be computed before calculating quick fixes
//   // await ref.watch(_isContextAnalyzingFilesProvider(root).future);
//   final results = await ref.watch(lintResultsForRootProvider(root).future);

//   final context = ref.watch(activeContextForRootProvider(root));
//   final resultsWithEdits = await Future.wait(results.map((e) async {
//     return fileService.computeEditResultsForAnalysisResult(context, e);
//   }));

//   return resultsWithEdits;
// }

// @riverpod
// Future<void> awaitContextStillAnalyzing(
//   AwaitContextStillAnalyzingRef ref,
//   ActiveContextRoot root,
// ) async {
//   final allContextFiles = ref.watch(analyzedFilesForRootProvider(root));
//   await Future.wait(allContextFiles.map(
//     (analyzedFile) async =>
//         ref.watch(analysisResultsForFileProvider(analyzedFile).future),
//   ));
// }
