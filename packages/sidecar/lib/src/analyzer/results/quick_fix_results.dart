import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/services.dart';
import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';
import 'analysis_results_provider.dart';
import 'edit_result.dart';

final quickFixForRequestProvider =
    FutureProvider.family<List<AnalysisErrorFixes>, EditRequest>(
  (ref, request) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final context = ref.watch(activeContextForRootProvider(request.file.root));
    final analysisResults =
        await ref.watch(analysisResultsForFileProvider(request.file).future);

    final analysisResultsForOffset = analysisResults.where(
        (element) => element.isWithinOffset(request.file.path, request.offset));
    ref.read(logDelegateProvider).sidecarMessage(
        'RESULTS FOR OFFSET: ${analysisResultsForOffset.length}');
    return Future.wait(analysisResultsForOffset.map((e) async {
      final edits =
          await fileService.calculateEditResultsForAnalysisResult(context, e);
      ref
          .read(logDelegateProvider)
          .sidecarMessage('RESULTS FOR OFFSET - EDITS: ${edits.length}');
      return AnalysisErrorFixes(e.toAnalysisError()!,
          fixes: edits.map((e) {
            ref.read(logDelegateProvider).sidecarMessage(
                'RESULTS FOR OFFSET - EDITS - SOURCE EDITS: ${e.sourceChanges.length}');
            return e.toPrioritizedSourceChange();
          }).toList());
    }));
  },
  name: 'quickFixForRequestProvider',
  dependencies: [
    logDelegateProvider,
    activeContextForRootProvider,
    fileAnalyzerServiceProvider,
    analysisResultsForFileProvider,
  ],
);

final analysisQuickFixResultsProvider =
    FutureProvider.family<List<EditResult>, ActiveContextRoot>(
  (ref, root) async {
    // final file = ref.watch(analyzedFileFromPath(request.file.path));
    final fileService = ref.watch(fileAnalyzerServiceProvider);

    // wait for all analysis results to be computed before calculating quick fixes
    await ref.watch(_isContextAnalyzingFilesProvider(root).future);
    final context = ref.watch(activeContextForRootProvider(root));

    final results = ref.watch(analysisResultsForContextProvider(root));

    final edits = await Future.wait(results.map((e) async {
      return fileService.calculateEditResultsForAnalysisResult(context, e);
    }));

    return edits.expand((e) => e).toList();
  },
  name: 'analysisQuickFixResultsProvider',
  dependencies: [
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
