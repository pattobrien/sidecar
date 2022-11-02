import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analysis_contexts_provider.g.dart';

// final allAnalysisContextsProvider = StateProvider<List<AnalysisContext>>(
//   (ref) => [],
//   name: 'allAnalysisContextsProvider',
//   dependencies: const [],
// );

@Riverpod(keepAlive: true)
class AllAnalysisContextsNotifier extends _$AllAnalysisContextsNotifier {
  @override
  List<AnalysisContext> build() {
    ref.onDispose(() {
      assert(true, 'disposing');
    });
    return [];
  }

  void update(AnalysisContextCollection collection) {
    state = collection.contexts;
  }
}
