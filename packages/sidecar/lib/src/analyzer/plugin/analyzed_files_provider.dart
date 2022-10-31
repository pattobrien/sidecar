import 'package:riverpod/riverpod.dart';

import '../context/context.dart';
import 'plugin.dart';

final analyzedFilesForRootProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) => root.typedAnalyzedFiles(),
  name: 'analyzedFilesForRootProvider',
  dependencies: const [],
);

final analyzedFileFromPath = Provider.family<AnalyzedFile, String>(
  (ref, path) {
    final activeContexts = ref.watch(activeContextsProvider);
    final context = activeContexts.contextForPath(path);
    final files = ref.watch(analyzedFilesForRootProvider(context!.activeRoot));
    return files.firstWhere((file) => file.path == path);
  },
  name: 'analyzedFileFromPath',
  dependencies: [
    activeContextsProvider,
    analyzedFilesForRootProvider,
  ],
);
