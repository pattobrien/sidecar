import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../../utils/glob_utils.dart';
import 'collection_provider.dart';
import 'project_configuration_provider.dart';

final activeProjectScopedFilesProvider =
    Provider<List<AnalyzedFileWithContext>>((ref) {
  // project globs update only when sidecar.yaml is saved
  final activeProjectGlobs = ref.watch(activeProjectGlobSetProvider);
  final contexts = ref.watch(contextCollectionProvider);
  final fileSystem = ref.watch(fileSystemProvider);
  final activeProjectScopedFiles = contexts
      .map((context) {
        final filesInScope = extractDartFilesFromFolders(
            ['lib'], context.contextRoot.root.path,
            fileSystem: fileSystem,
            globalIncludes: activeProjectGlobs,
            globalExcludes: []);

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

final fileSystemProvider =
    Provider<FileSystem>((ref) => const LocalFileSystem());
