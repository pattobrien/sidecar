import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../services/services.dart';
import '../../utils/file_paths.dart';
import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../results/results.dart';
import 'plugin.dart';

final activeContextsProvider = Provider<List<ActiveContext>>(
  (ref) {
    final service = ref.watch(activeProjectServiceProvider);
    final allContexts = ref.watch(allAnalysisContextsProvider);

    final activeContexts = allContexts
        .map(service.initializeContext)
        .whereType<ActiveContext>()
        .toList();
    final dependencies = activeContexts
        .map((e) => service.getActiveDependencies(e, allContexts))
        .expand((e) => e);

    logger.finer('# of all contexts => ${allContexts.length} ');
    logger.finer('# of active contexts => ${activeContexts.length} ');
    for (final activeContext in activeContexts) {
      logger.finer('active context => ${activeContext.activeRoot.root.path}');
    }
    return [...activeContexts, ...dependencies];
  },
  name: 'activeContextsProvider',
  dependencies: [
    activeProjectServiceProvider,
    allAnalysisContextsProvider,
  ],
);

final activeContextRootsProvider = Provider<List<ActiveContextRoot>>(
  (ref) => ref.watch(activeContextsProvider).map((e) => e.activeRoot).toList(),
  name: 'activeContextRootsProvider',
  dependencies: [
    activeContextsProvider,
  ],
);

final activeContextForRootProvider =
    Provider.family<ActiveContext, ActiveContextRoot>(
  (ref, root) {
    final configSub = _listenToConfigForChanges(ref, root);
    ref.onDispose(() => configSub?.cancel());
    return ref.watch(activeContextsProvider.select((activeContexts) =>
        activeContexts.firstWhere((activeContext) =>
            activeContext.activeRoot.root.path == root.root.path)));
  },
  name: 'activeContextForContextRootProvider',
  dependencies: [
    activeContextsProvider,
  ],
);

StreamSubscription? _listenToConfigForChanges(Ref ref, ActiveContextRoot root) {
  final path = p.join(root.root.path, kSidecarYaml);
  final file = root.resourceProvider.getFile(path);
  if (!file.exists) return null;
  final resourceWatcher = file.watch();
  return resourceWatcher.changes.listen((event) {
    // if (event.type != ChangeType.REMOVE) {
    ref.invalidate(activeContextsProvider);
    ref.invalidate(activeContextForRootProvider(root));
    ref.invalidate(activatedRulesProvider);
    for (final file in root.typedAnalyzedFiles()) {
      ref.invalidate(analysisResultsForFileProvider(file));
      ref.refresh(analysisResultsReporterProvider(file));
    }
    // }
  });
}
