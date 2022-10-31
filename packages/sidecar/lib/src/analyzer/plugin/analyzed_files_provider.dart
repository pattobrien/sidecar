import 'package:riverpod/riverpod.dart';

import '../context/context.dart';
import 'plugin.dart';

final analyzedFilesProvider =
    Provider.family<List<AnalyzedFile>, ActiveContextRoot>(
  (ref, root) => root.typedAnalyzedFiles().toList(),
  name: 'analyzedFilesProvider',
  dependencies: const [],
);

final analyzedFileFromPath = Provider.family<AnalyzedFile, String>(
  (ref, path) {
    final activeContexts = ref.watch(activeContextsProvider);
    final context = activeContexts.contextForPath(path);
    final analyzedFiles = ref.watch(analyzedFilesProvider(context!.activeRoot));
    return analyzedFiles.firstWhere((file) => file.path == path);
  },
  name: 'analyzedFileFromPath',
  dependencies: [
    activeContextsProvider,
    analyzedFilesProvider,
  ],
);
