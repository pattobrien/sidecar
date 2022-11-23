import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../../utils/glob_utils.dart';
import 'analyzer_resource_provider.dart';
import 'collection_provider.dart';
import 'project_configuration_provider.dart';

final activeProjectScopedFilesProvider =
    Provider<List<AnalyzedFileWithContext>>((ref) {
  final activeProjectIncludes = ref.watch(activeProjectIncludeGlobsProvider);
  final activeProjectExcludes = ref.watch(activeProjectExcludeGlobsProvider);
  final contexts = ref.watch(contextCollectionProvider);
  final fileSystem = ref.watch(fileSystemProvider);

  final activeProjectScopedFiles = contexts
      .map((context) {
        final filesInScope = extractDartFilesFromFolders(
            ['lib'], context.contextRoot.root.path,
            fileSystem: fileSystem,
            globalIncludes: activeProjectIncludes,
            globalExcludes: activeProjectExcludes);

        final files = filesInScope
            .map((e) => AnalyzedFileWithContext(Uri.parse(e), context: context))
            .whereType<AnalyzedFileWithContext>()
            .toList();
        return files;
      })
      .expand((e) => e)
      .toList();
  return activeProjectScopedFiles;
});
