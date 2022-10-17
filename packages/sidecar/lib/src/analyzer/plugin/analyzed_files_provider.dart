import 'package:riverpod/riverpod.dart';

import '../context/context.dart';
import 'plugin.dart';

final analyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) {
    return ref
        .watch(_unfilteredAnalyzedFilesProvider(root))
        // .where((analyzedFile) => !analyzedFile.isSidecarYamlFile)
        .toList();
  },
  name: 'analyzedFilesProvider',
  dependencies: [
    _unfilteredAnalyzedFilesProvider,
  ],
);

final analyzedFileFromPath = Provider.family<AnalyzedFile, String>(
  (ref, path) {
    final activeContexts = ref.watch(activeContextsProvider);
    final context = activeContexts.firstWhere((activeContext) =>
        activeContext.activeRoot.analyzedFiles().any((file) => file == path));
    final analyzedFiles = ref.watch(analyzedFilesProvider(context.activeRoot));
    return analyzedFiles.firstWhere((element) => element.path == path);
  },
  name: 'analyzedFileFromPath',
  dependencies: [
    activeContextsProvider,
    analyzedFilesProvider,
  ],
);

final sidecarYamlFileProvider =
    Provider.family<AnalyzedFile, ActiveContextRoot>(
  (ref, root) {
    return ref.watch(_unfilteredAnalyzedFilesProvider(root).select((files) =>
        files.singleWhere(
            (analyzedFile) => analyzedFile.isAnalysisOptionsFile)));
  },
  name: 'sidecarYamlFileProvider',
  dependencies: [
    _unfilteredAnalyzedFilesProvider,
  ],
);

final _unfilteredAnalyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) {
    return root.typedAnalyzedFiles().toList();
  },
  name: '_unfilteredAnalyzedFilesProvider',
  dependencies: [],
);
