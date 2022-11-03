import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../handlers/context_collection.dart';
import 'analyzer_plugin.dart';

part 'analysis_contexts_provider.g.dart';

@riverpod
List<AnalysisContext> allContexts(
  AllContextsRef ref,
  // SidecarAnalyzer analyzer,
  // List<AnalysisContext> contexts,
) {
  // final collection = ref.watch(contextCollectionProvider);
  return [];
}
