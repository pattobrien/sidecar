import 'package:analyzer/dart/analysis/analysis_context.dart';
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

// @riverpod
// List<AnalyzedFile> analyzedFilesForContext(
//   AnalyzedFilesForRootRef ref,
//   AnalysisContext context,
// ) {
//   final filePaths = context.contextRoot.analyzedFiles();
//   // filePaths.map((e) => ref.watch(analyzedFileForPathProvider(e)));
//   // final ctx = ;
//   // return ctx.contextRoot
//   //     .analyzedFiles()
//   //     .map((e) => AnalyzedFile(context, Uri.parse(e)))
//   //     .toList();
// }

@riverpod
AnalyzedFile analyzedFileForPath(
  AnalyzedFileForPathRef ref,
  String path,
) {
  final analysisContexts = ref.watch(allContextsNotifierProvider);
  final contextForPath = analysisContexts.contextRootForPath(path);
  final files = ref.watch(analyzedFilesForRootProvider(contextForPath!));
  return files.firstWhere((element) => element.path == path);
}
