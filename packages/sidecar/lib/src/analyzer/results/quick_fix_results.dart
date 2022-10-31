import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/services.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';
import 'analysis_result.dart';
import 'analysis_results_provider.dart';

final quickFixForRequestProvider =
    FutureProvider.family<List<AnalysisErrorFixes>, EditRequest>(
  (ref, request) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final context = ref.watch(activeContextForRootProvider(request.file.root));
    final lintResults =
        await ref.watch(lintResultsForFileProvider(request.file).future);

    final analysisResultsForOffset = lintResults.where(
        (element) => element.isWithinOffset(request.file.path, request.offset));
    return Future.wait(analysisResultsForOffset.map((e) async {
      final resultWithEdits =
          await fileService.computeEditResultsForAnalysisResult(context, e);
      return resultWithEdits.toAnalysisErrorFixes();
    }));
  },
  name: 'quickFixForRequestProvider',
  dependencies: [
    activeContextForRootProvider,
    fileAnalyzerServiceProvider,
    analysisResultsForFileProvider,
    lintResultsForFileProvider,
  ],
);

final analysisQuickFixResultsProvider =
    FutureProvider.family<List<LintResult>, ActiveContextRoot>(
  (ref, root) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);

    // wait for all analysis results to be computed before calculating quick fixes
    // await ref.watch(_isContextAnalyzingFilesProvider(root).future);
    final results = await ref.watch(lintResultsForContextProvider(root).future);

    final context = ref.watch(activeContextForRootProvider(root));
    final resultsWithEdits = await Future.wait(results.map((e) async {
      return fileService.computeEditResultsForAnalysisResult(context, e);
    }));

    return resultsWithEdits;
  },
  name: 'analysisQuickFixResultsProvider',
  dependencies: [
    lintResultsForContextProvider,
    fileAnalyzerServiceProvider,
    analysisResultsForContextProvider,
    activeContextForRootProvider,
    _isContextAnalyzingFilesProvider,
  ],
);

final _isContextAnalyzingFilesProvider =
    FutureProvider.family<void, ActiveContextRoot>(
  (ref, activeRoot) async {
    final allContextFiles = ref.watch(analyzedFilesForRootProvider(activeRoot));
    await Future.wait(allContextFiles.map(
      (analyzedFile) async =>
          ref.watch(analysisResultsForFileProvider(analyzedFile).future),
    ));
  },
  name: '_isContextAnalyzingFilesProvider',
  dependencies: [
    analyzedFilesForRootProvider,
    analysisResultsForFileProvider,
  ],
);
