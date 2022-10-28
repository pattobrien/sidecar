import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../services/services.dart';
import '../../utils/file_paths.dart';
import '../context/context.dart';
import '../results/analysis_results_provider.dart';
import '../results/analysis_results_reporter.dart';
import 'plugin.dart';

final activeContextsProvider = Provider<List<ActiveContext>>(
  (ref) {
    final activePackageService = ref.watch(activeProjectServiceProvider);
    final allContexts = ref.watch(allAnalysisContextsProvider);
    final results = allContexts.map(activePackageService.initializeContext);
    // print('# of active roots = ${results.length}');
    return results.whereType<ActiveContext>().toList();
  },
  name: 'activeContextsProvider',
  dependencies: [
    activeProjectServiceProvider,
    allAnalysisContextsProvider,
  ],
);

final activeContextRootsProvider = Provider<List<ActiveContextRoot>>(
  (ref) {
    final activeRoots =
        ref.watch(activeContextsProvider).map((e) => e.activeRoot).toList();
    // print('# of active roots = ${activeRoots.length}');
    return activeRoots;
  },
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
