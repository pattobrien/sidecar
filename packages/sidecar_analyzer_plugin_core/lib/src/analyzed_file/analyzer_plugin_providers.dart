import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import 'analyzed_file.dart';
import 'edit_request.dart';
import 'sidecar_results.dart';

final analysisErrorsProvider =
    FutureProvider.family<List<AnalysisError>, AnalyzedFile>(
  (ref, analyzedFile) async {
    final results = await ref.watch(fileLintResults(analyzedFile).future);
    return results.map((e) => e.toAnalysisError()!).toList();
  },
  dependencies: [fileLintResults],
);

final analysisErrorFixesProvider =
    FutureProvider.family<List<AnalysisErrorFixes>, EditRequest>(
  (ref, editRequest) async {
    final results =
        await ref.watch(fileLintResultsAtOffset(editRequest).future);
    final editResults = await ref.watch(fileEditResults(editRequest).future);

    final errorFixes = await Future.wait(results.map((analysisResult) async {
      return AnalysisErrorFixes(
        analysisResult.toAnalysisError()!,
        fixes: await Future.wait(editResults
            .where((editResult) =>
                editResult.analysisResult.sourceSpan ==
                analysisResult.sourceSpan)
            .map((e) async => e.toPrioritizedSourceChange())),
      );
    }));
    return errorFixes.where((element) => element.fixes.isNotEmpty).toList();
  },
  dependencies: [
    fileLintResultsAtOffset,
    fileEditResults,
  ],
);
