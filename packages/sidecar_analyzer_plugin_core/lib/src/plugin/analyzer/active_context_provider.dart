import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

final activePluginContextsProvider =
    StateNotifierProvider<ActivePluginContextsNotifier, List<AnalysisContext>>(
        (ref) => ActivePluginContextsNotifier());

final activeContextRootsProvider = Provider<List<ContextRoot>>((ref) {
  return ref
      .watch(activePluginContextsProvider)
      .map((e) => e.contextRoot)
      .toList();
});

class ActivePluginContextsNotifier
    extends StateNotifier<List<AnalysisContext>> {
  ActivePluginContextsNotifier() : super([]);

  void update(AnalysisContext context) {
    // handle logic for how and when context should be updated
  }
}
