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

@riverpod
AnalyzedFile analyzedFileForPath(
  AnalyzedFileForPathRef ref,
  String path,
) {
  final contextRootForPath = ref.watch(allContextsNotifierProvider
      .select((value) => value.contextRootForPath(path)));
  final uri = Uri.parse(path);
  final files = ref.watch(analyzedFilesForRootProvider(contextRootForPath!));
  return files.firstWhere((element) => element.fileUri == uri);
}
