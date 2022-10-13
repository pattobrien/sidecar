import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/utils.dart';
import 'analyzed_file.dart';

final _unfilteredAnalyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ContextRoot>((ref, root) {
  return root.typedAnalyzedFiles().toList();
});

final analyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ContextRoot>((ref, root) {
  return ref
      .watch(_unfilteredAnalyzedFilesProvider(root))
      .where((analyzedFile) => !analyzedFile.isAnalysisOptionsFile)
      .toList();
});

final analyzedOptionsFileProvider =
    Provider.family<AnalyzedFile, ContextRoot>((ref, root) {
  return ref.watch(_unfilteredAnalyzedFilesProvider(root).select((files) =>
      files.singleWhere((analyzedFile) => analyzedFile.isAnalysisOptionsFile)));
});
