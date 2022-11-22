import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';

final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFileWithContext>(
        (ref, file) async {
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;
  final result = await file.context.currentSession.getResolvedUnit(file.path);
  return result as ResolvedUnitResult;
});
