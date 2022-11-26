import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/analyzer/plugin/collection_provider.dart';
import '../../utils/utils.dart';

import '../../protocol/analyzed_file.dart';

final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>((ref, file) async {
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;
  final context = ref.watch(contextForFileProvider(file));
  final result = await context.currentSession.getResolvedUnit(file.path);
  return result as ResolvedUnitResult;
});

final contextForFileProvider = Provider.family<AnalysisContext, AnalyzedFile>(
  (ref, file) {
    final contexts = ref.watch(contextCollectionProvider);
    return contexts.contextForPath(file.fileUri.toString())!;
  },
);
