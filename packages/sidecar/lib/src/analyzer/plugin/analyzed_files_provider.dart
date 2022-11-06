import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../protocol/models/models.dart';
import '../context/context.dart';
import 'plugin.dart';

part 'analyzed_files_provider.g.dart';

@riverpod
List<AnalyzedFile> analyzedFilesForRoot(
  AnalyzedFilesForRootRef ref,
  Context context,
) {
  final ctx = ref.watch(analysisContextForRootProvider(context));
  return ctx.contextRoot
      .analyzedFiles()
      .map((e) => AnalyzedFile(context, Uri.parse(e)))
      .toList();
}

//TODO: can we remove the analyzer parameter from here
// and depend only on a ContextRoot ?
@riverpod
AnalyzedFile analyzedFileForPath(
  AnalyzedFileForPathRef ref,
  // SidecarAnalyzer analyzer,
  String path,
) {
  final analysisContexts = ref.watch(allContextsNotifierProvider);
  final contextForPath = analysisContexts.contextRootForPath(path);
  final files = ref.watch(analyzedFilesForRootProvider(contextForPath!));
  return files.firstWhere((element) => element.path == path);
}
