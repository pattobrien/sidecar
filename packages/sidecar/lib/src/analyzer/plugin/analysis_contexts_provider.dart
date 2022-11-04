import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analysis_contexts_provider.g.dart';

// @riverpod
// List<AnalysisContext> allContexts(
//   AllContextsRef ref,
//   // SidecarAnalyzer analyzer,
//   // List<AnalysisContext> contexts,
// ) {
//   final collection = ref.watch(createContextCollection);
//   return [];
// }

@Riverpod(keepAlive: true)
class AllContextsNotifier extends _$AllContextsNotifier {
  @override
  List<AnalysisContext> build() {
    return [];
  }

  void update(AnalysisContextCollection collection) {
    state = collection.contexts;
  }
}
