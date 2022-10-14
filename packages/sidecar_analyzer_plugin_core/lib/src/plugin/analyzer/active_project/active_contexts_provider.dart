import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';
import '../analysis_contexts_provider.dart';

final activeContextsProvider = Provider<List<ActiveContext>>(
  (ref) {
    final activePackageService = ref.watch(activePackageServiceProvider);
    final allContexts = ref.watch(allAnalysisContextsProvider);
    ref.watch(logDelegateProvider).sidecarMessage(
        'activeContextsProvider refresh : ${allContexts.toString()}');
    final initializedContexts =
        allContexts.map(activePackageService.initializeContext).toList();
    return initializedContexts.whereType<ActiveContext>().toList();
  },
  name: 'activeContextsProvider',
  dependencies: [
    activePackageServiceProvider,
    allAnalysisContextsProvider,
    logDelegateProvider,
  ],
);

final activeContextRootsProvider = Provider<List<ActiveContextRoot>>(
  (ref) {
    return ref.watch(activeContextsProvider.select(
        (contexts) => contexts.map((context) => context.activeRoot).toList()));
  },
  name: 'activeContextRootsProvider',
  dependencies: [
    activeContextsProvider,
  ],
);

final activeContextForFileProvider =
    Provider.family<ActiveContext, AnalyzedFile>(
  (ref, file) {
    return ref.watch(activeContextsProvider.select((contexts) =>
        contexts.firstWhere((context) => context.activeRoot
            .analyzedFiles()
            .any((filePath) => filePath == file.path))));
  },
  name: 'activeContextForFileProvider',
  dependencies: [
    activeContextsProvider,
  ],
);

final activeContextForContextRootProvider =
    Provider.family<ActiveContext, ActiveContextRoot>(
  (ref, root) {
    return ref.watch(activeContextsProvider.select((activeContexts) =>
        activeContexts.firstWhere((activeContext) =>
            activeContext.activeRoot.root.path == root.root.path)));
  },
  name: 'activeContextForContextRootProvider',
  dependencies: [
    activeContextsProvider,
  ],
);
