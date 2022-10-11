import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'analyzed_file.dart';
import 'analyzed_file_providers.dart';
import 'edit_request.dart';

final fileLintResults =
    FutureProvider.family<Iterable<AnalysisResult>, AnalyzedFile>(
        (ref, file) async {
  final results = await ref.watch(_sidecarBaseAnalysisResults(file).future);
  return results.where((result) => result.rule.type == IdType.lintRule);
}, dependencies: [_sidecarBaseAnalysisResults]);

final fileEditResults =
    FutureProvider.family<Iterable<EditResult>, EditRequest>(
        (ref, request) async {
  final service =
      await ref.watch(analyzedFileServiceProvider(request.file).future);
  final results = await ref.watch(fileLintResultsAtOffset(request).future);
  return service.calculateEditResults(
      results, request.file.path, request.offset);
}, dependencies: [
  analyzedFileServiceProvider,
  fileLintResultsAtOffset,
]);

final fileLintResultsAtOffset =
    FutureProvider.family<Iterable<AnalysisResult>, EditRequest>(
  (ref, request) async {
    final service =
        await ref.watch(analyzedFileServiceProvider(request.file).future);
    final analysisResults =
        await ref.watch(fileLintResults(request.file).future);
    return service.calculateAnalysisResultsAtOffset(
        analysisResults, request.file.path, request.offset);
  },
  dependencies: [analyzedFileServiceProvider, fileLintResults],
);

final _sidecarBaseAnalysisResults =
    FutureProvider.family<Iterable<AnalysisResult>, AnalyzedFile>(
  (ref, file) async {
    final service = await ref.watch(analyzedFileServiceProvider(file).future);
    return service.computeAnalysisResults(file);
  },
  dependencies: [analyzedFileServiceProvider],
);
