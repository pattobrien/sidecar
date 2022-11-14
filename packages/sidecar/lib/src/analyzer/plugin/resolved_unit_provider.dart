import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';

final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFileWithContext>(
        (ref, file) async {
  // final watch = Stopwatch()..start();
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;
  final result = await file.context.currentSession.getResolvedUnit(file.path);
  // print('resolvedUnitForFile ${watch.elapsed.prettified()} ${file.path}');
  return result as ResolvedUnitResult;
});

// final unitContextProvider = FutureProvider.family
//     .autoDispose<UnitContext?, AnalyzedFileWithContext>((ref, file) async {
//   final result = await ref.watch(resolvedUnitForFileProvider(file).future);
//   final configuration = ref.watch(projectConfigurationProvider);

//   if (result == null) return null;
//   final unitContext = UnitContextImpl(
//       currentUnit: result.unit,
//       sourceUri: result.uri,
//       contents: result.content,
//       configuration: configuration);

//   return unitContext;
// });
