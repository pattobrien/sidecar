import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/active_project_service.dart';
import '../context/active_context.dart';
import 'analyzer_resource_provider.dart';

part 'analysis_contexts_provider.g.dart';

@Riverpod(keepAlive: true)
class AllContextsNotifier extends _$AllContextsNotifier {
  @override
  List<AnalysisContext> build() {
    return [];
  }

  void update(AnalysisContextCollection collection) {
    final activeContext = ref.watch(activeContextNotifierProvider);
    assert(activeContext != null, 'active context should have been set by now');
    final config = activeContext!.packageConfigJson;
    state = collection.contexts
        .where((context) => config.packages
            .any((package) => package.root == context.contextRoot.root.toUri()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
class ActiveContextNotifier extends _$ActiveContextNotifier {
  @override
  ActiveContext? build() {
    return null;
  }

  void updateRoot(Uri root) {
    final service = ref.watch(activeProjectServiceProvider);
    final resourceProvider = ref.watch(analyzerResourceProvider);
    final activeContext = service.initActiveContextFromUri(root,
        resourceProvider: resourceProvider);
    assert(activeContext != null,
        'ActiveContext was not found at root: ${root.path}');
    state = activeContext;
  }
}

// @riverpod
// List<AnalysisContext> allContexts(AllContextsRef ref) {
//   final activeContext = ref.watch(activeContextNotifierProvider);
//   activeContext.
//   return [];
// }
