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
    final activeContexts =
        allContexts.map(service.initializeContext).whereType<ActiveContext>();

    final dependencies = activeContexts
        .map((e) => service.getActiveDependencies(e, allContexts))
        .expand((e) => e);

    logger.finer('# of all contexts => ${allContexts.length} ');
    logger.finer('# of active contexts => ${activeContexts.length} ');
    for (final activeContext in activeContexts) {
      logger.finer('active context => ${activeContext.activeRoot.root.path}');
    }
    final activeContextsAndDependencies = [...activeContexts, ...dependencies];
    assert(activeContextsAndDependencies.where((c) => c.isMainRoot).length == 1,
        'There should only ever be 1 main active context for each isolate.');
    return activeContextsAndDependencies;
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
  final sidecarConfigPath = p.join(root.root.path, kSidecarYaml);
  final sidecarConfigFile = root.resourceProvider.getFile(sidecarConfigPath);
  if (!sidecarConfigFile.exists) return null;

  final resourceWatcher = sidecarConfigFile.watch();
  return resourceWatcher.changes.listen((event) {
    ref.invalidate(activeContextsProvider);
    ref.invalidate(activeContextForRootProvider(root));
    ref.invalidate(activatedRulesProvider);
    for (final file in root.typedAnalyzedFiles()) {
      ref.invalidate(analysisResultsForFileProvider(file));
      ref.refresh(analysisResultsReporterProvider(file));
    }
  });
}
