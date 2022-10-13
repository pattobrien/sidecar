import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../analyzer.dart';

final analyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) {
    return ref
        .watch(_unfilteredAnalyzedFilesProvider(root))
        .where((analyzedFile) => !analyzedFile.isAnalysisOptionsFile)
        .toList();
  },
  dependencies: [
    _unfilteredAnalyzedFilesProvider,
  ],
);

final analyzedFileFromPath = Provider.family<AnalyzedFile, String>((ref, path) {
  final activeContexts = ref.watch(activeContextsProvider);
  final context = activeContexts
      .firstWhere((activeContext) => activeContext.activeRoot.isAnalyzed(path));
  final analyzedFiles = ref.watch(analyzedFilesProvider(context.activeRoot));
  return analyzedFiles.firstWhere((element) => element.path == path);
});

final analyzedOptionsFileProvider =
    Provider.family<AnalyzedFile, ActiveContextRoot>(
  (ref, root) {
    return ref.watch(_unfilteredAnalyzedFilesProvider(root).select((files) =>
        files.singleWhere(
            (analyzedFile) => analyzedFile.isAnalysisOptionsFile)));
  },
  dependencies: [
    _unfilteredAnalyzedFilesProvider,
  ],
);

final _unfilteredAnalyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) {
    return root.typedAnalyzedFiles().toList();
  },
  dependencies: [],
);
