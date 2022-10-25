import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../context/context.dart';
import '../server.dart';

/// All contexts properly enabled for Sidecar
///
/// ActiveContexts represent 100% fully initialized contexts, including:
/// - initialized sidecar.yaml configuration
/// - list of all sidecar dependencies
/// - sidecar_analyzer_plugin package information
final activeContextsMiddlemanProvider = Provider<List<ActiveContext>>(
  (ref) {
    final allContexts = ref.watch(allContextsProvider);
    final service = ref.watch(activeProjectServiceProvider);
    return allContexts
        .map<ActiveContext?>(service.initializeContext)
        .whereType<ActiveContext>()
        .toList();
  },
  name: 'activeContextsProvider',
  dependencies: [
    allContextsProvider,
    activeProjectServiceProvider,
  ],
);

final activeContextForContextRootProvider =
    Provider.family<ActiveContext, ActiveContextRoot>(
  (ref, root) {
    return ref.watch(activeContextsMiddlemanProvider.select((activeContexts) =>
        activeContexts.firstWhere((context) => context.activeRoot == root)));
  },
  name: 'activeContextForContextRootProvider',
  dependencies: [
    activeContextsMiddlemanProvider,
  ],
);

final activeContextRootsProvider = Provider<List<ActiveContextRoot>>(
  (ref) {
    final activeContexts = ref.watch(activeContextsMiddlemanProvider);
    return activeContexts.map((e) => ActiveContextRoot(e.contextRoot)).toList();
  },
  name: 'activeContextRootsProvider',
  dependencies: [
    activeContextsMiddlemanProvider,
  ],
);
