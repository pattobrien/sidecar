import 'package:riverpod/riverpod.dart';

import '../../utils/glob_utils.dart';
import '../context/analyzed_file.dart';
import 'collection_provider.dart';
import 'project_configuration_provider.dart';

final activeProjectScopedFilesProvider =
    Provider<List<AnalyzedFileWithContext>>((ref) {
  // project globs update only when sidecar.yaml is saved
  final activeProjectGlobs = ref.watch(activeProjectGlobSetProvider);
  final contexts = ref.watch(contextCollectionProvider);
  final activeProjectScopedFiles = contexts
      .map((context) {
        final filesInScope = extractDartFilesFromFolders(
            ['lib'], context.contextRoot.root.path,
            globalIncludes: activeProjectGlobs, globalExcludes: []);

        return filesInScope
            .map((e) => AnalyzedFileWithContext(Uri.parse(e), context: context))
            .whereType<AnalyzedFileWithContext>()
            .toList();
      })
      .expand((e) => e)
      .toList();
  return activeProjectScopedFiles;
});
