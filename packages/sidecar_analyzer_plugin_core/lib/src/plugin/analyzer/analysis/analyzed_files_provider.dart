import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';

final analyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>((ref, root) {
  return ref
      .watch(_unfilteredAnalyzedFilesProvider(root))
      .where((analyzedFile) => !analyzedFile.isAnalysisOptionsFile)
      .toList();
});

final analyzedOptionsFileProvider =
    Provider.family<AnalyzedFile, ActiveContextRoot>((ref, root) {
  return ref.watch(_unfilteredAnalyzedFilesProvider(root).select((files) =>
      files.singleWhere((analyzedFile) => analyzedFile.isAnalysisOptionsFile)));
});

final _unfilteredAnalyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>((ref, root) {
  return root.typedAnalyzedFiles().toList();
});
