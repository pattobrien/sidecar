import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../../utils/utils.dart';
import 'context_collection_provider.dart';

/// Analyze a Dart file and generate the Element/ASTNode/Type structures.
final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>((ref, file) async {
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;

  final contexts = ref.watch(contextCollectionProvider);
  final context = contexts.contextForRoot(file.contextRoot);
  if (context == null) return null;
  final result = await context.currentSession.getResolvedUnit(file.path);
  return result as ResolvedUnitResult;
});
