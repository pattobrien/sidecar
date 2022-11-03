import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../context/context.dart';
import 'plugin.dart';
import 'sidecar_analyzer.dart';

part 'analyzed_files_provider.g.dart';

@riverpod
List<AnalyzedFile> analyzedFilesForRoot(
  AnalyzedFilesForRootRef ref,
  ActiveContextRoot root,
) {
  return root.analyzedFiles();
}

//TODO: can we remove the analyzer parameter from here
// and depend only on a ContextRoot ?
@riverpod
AnalyzedFile analyzedFileForPath(
  AnalyzedFileForPathRef ref,
  SidecarAnalyzer analyzer,
  String path,
) {
  final activeContexts = ref.watch(activeContextsProvider);
  final contextForPath = activeContexts.contextForPath(path);
  final files =
      ref.watch(analyzedFilesForRootProvider(contextForPath!.activeRoot));
  return files.firstWhere((element) => element.path == path);
}
