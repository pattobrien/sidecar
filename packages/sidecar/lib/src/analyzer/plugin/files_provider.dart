import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../../utils/glob_utils.dart';
import 'analyzer_resource_provider.dart';
import 'collection_provider.dart';
import 'sidecar_spec_providers.dart';

final activeProjectScopedFilesProvider = Provider<List<AnalyzedFile>>((ref) {
  final activeProjectIncludes = ref.watch(activeProjectIncludeGlobsProvider);
  final activeProjectExcludes = ref.watch(activeProjectExcludeGlobsProvider);
  final contexts = ref.watch(contextCollectionProvider);
  final fileSystem = ref.watch(fileSystemProvider);

  final activeProjectScopedFiles = contexts
      .map((context) {
        //TODO: add rule/package includes and excludes
        final filesInScope = extractDartFilesFromFolders(
            ['lib'], context.contextRoot.root.path,
            fileSystem: fileSystem,
            globalIncludes: activeProjectIncludes,
            globalExcludes: activeProjectExcludes);

        final files = filesInScope
            .map((e) => AnalyzedFile(Uri.parse(e),
                contextRoot: context.contextRoot.root.toUri()))
            .toList();
        return files;
      })
      .expand((e) => e)
      .toList();
  return activeProjectScopedFiles;
});
