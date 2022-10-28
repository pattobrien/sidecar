import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/services.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';
import '../server/log_delegate.dart';
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
    ref.read(logDelegateProvider).sidecarVerboseMessage(
        'RESULTS FOR OFFSET: ${analysisResultsForOffset.length}');
    // return [];
    return Future.wait(analysisResultsForOffset.map((e) async {
      final lintResultsWithEdits =
          await fileService.calculateEditResultsForAnalysisResult(context, e);
      ref.read(logDelegateProvider).sidecarVerboseMessage(
          'RESULTS FOR OFFSET - EDITS: ${lintResultsWithEdits.edits.length}');
      return AnalysisErrorFixes(e.toAnalysisError(),
          fixes: lintResultsWithEdits.edits.map((edit) {
            ref.read(logDelegateProvider).sidecarVerboseMessage(
                'RESULTS FOR OFFSET - EDITS - SOURCE EDITS: ${edit.sourceChanges.length}');
            return edit.toPrioritizedSourceChange();
          }).toList());
    }));
  },
  name: 'quickFixForRequestProvider',
  dependencies: [
    logDelegateProvider,
    activeContextForRootProvider,
    fileAnalyzerServiceProvider,
    analysisResultsForFileProvider,
    lintResultsForFileProvider,
  ],
);

final analysisQuickFixResultsProvider =
    FutureProvider.family<List<LintResult>, ActiveContextRoot>(
  (ref, root) async {
    // final file = ref.watch(analyzedFileFromPath(request.file.path));
    final fileService = ref.watch(fileAnalyzerServiceProvider);

    // wait for all analysis results to be computed before calculating quick fixes
    // await ref.watch(_isContextAnalyzingFilesProvider(root).future);
    final results = await ref.watch(lintResultsForContextProvider(root).future);

    final context = ref.watch(activeContextForRootProvider(root));
    final resultsWithEdits = await Future.wait(results.map((e) async {
      return fileService.calculateEditResultsForAnalysisResult(context, e);
    }));

    return resultsWithEdits;
    // return [];
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
    final allContextFiles = ref.watch(analyzedFilesProvider(activeRoot));
    await Future.wait(allContextFiles.map(
      (analyzedFile) async =>
          ref.watch(analysisResultsForFileProvider(analyzedFile).future),
    ));
  },
  name: '_isContextAnalyzingFilesProvider',
  dependencies: [
    analyzedFilesProvider,
    analysisResultsForFileProvider,
  ],
);
