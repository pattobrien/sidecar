import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../../utils/utils.dart';
import 'context_collection_provider.dart';
import 'sidecar_analyzer.dart';

/// Analyze a Dart file and generate the Element/ASTNode/Type structures.
final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>((ref, file) async {
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;

  final context = ref.watch(_contextForFileProvider(file));
  if (context == null) return null;

  final result = await timedLogAsync('getResolvedUnit',
      () async => context.currentSession.getResolvedUnit(file.path));
  return result as ResolvedUnitResult;
});

final _contextForFileProvider = Provider.family<AnalysisContext?, AnalyzedFile>(
  (ref, file) {
    final contexts = ref.watch(contextCollectionProvider);
    return contexts.contextForRoot(file.contextRoot);
  },
);
