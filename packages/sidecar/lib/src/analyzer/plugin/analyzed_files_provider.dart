import 'package:riverpod/riverpod.dart';

import '../context/context.dart';
import 'plugin.dart';

final analyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) => ref.watch(_unfilteredAnalyzedFilesProvider(root)).toList(),
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
    return analyzedFiles.firstWhere((file) => file.path == path);
  },
  name: 'analyzedFileFromPath',
  dependencies: [
    activeContextsProvider,
    analyzedFilesProvider,
  ],
);

final _unfilteredAnalyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) => root.typedAnalyzedFiles().toList(),
  name: '_unfilteredAnalyzedFilesProvider',
  dependencies: [],
);
