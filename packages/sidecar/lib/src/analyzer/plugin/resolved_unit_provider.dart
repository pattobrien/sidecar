import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/duration_ext.dart';
import '../context/analyzed_file.dart';
import '../context/unit_context.dart';
import 'project_configuration_provider.dart';

final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFileWithContext>(
        (ref, file) async {
  final watch = Stopwatch()..start();
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;
  final result = await file.context.currentSession.getResolvedUnit(file.path);
  print('resolvedUnitForFileProvider - ${watch.elapsed.prettified()}');
  return result as ResolvedUnitResult;
});

final unitContextProvider =
    FutureProvider.family<UnitContext?, AnalyzedFileWithContext>(
        (ref, file) async {
  final result = await ref.watch(resolvedUnitForFileProvider(file).future);
  final configuration = ref.watch(projectConfigurationProvider);

  if (result == null) return null;
  final unitContext = UnitContextImpl(
      currentUnit: result.unit,
      sourceUri: result.uri,
      contents: result.content,
      configuration: configuration);

  return unitContext;
});
