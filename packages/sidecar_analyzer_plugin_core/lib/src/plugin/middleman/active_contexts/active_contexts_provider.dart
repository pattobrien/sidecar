import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';
import '../analysis_context_providers.dart';

/// All contexts properly enabled for Sidecar
///
/// ActiveContexts represent 100% fully initialized contexts, including:
/// - initialized sidecar.yaml configuration
/// - list of all sidecar dependencies
/// - sidecar_analyzer_plugin package information
final activeContextsProvider = Provider<List<ActiveContext>>(
  (ref) {
    final allContexts = ref.watch(allContextsProvider);
    final service = ref.watch(activePackageServiceProvider);

    return allContexts
        .map<ActiveContext?>(service.initializeContext)
        .whereType<ActiveContext>()
        .toList();
  },
  dependencies: [
    allContextsProvider,
    activePackageServiceProvider,
  ],
);

final activeContextForContextRootProvider =
    Provider.family<ActiveContext, ActiveContextRoot>(
  (ref, root) {
    return ref.watch(activeContextsProvider.select((activeContexts) =>
        activeContexts.firstWhere((context) => context.activeRoot == root)));
  },
  dependencies: [
    activeContextsProvider,
  ],
);

final activeContextRootsProvider = Provider<List<ActiveContextRoot>>(
  (ref) {
    final activeContexts = ref.watch(activeContextsProvider);
    return activeContexts.map((e) => ActiveContextRoot(e.contextRoot)).toList();
  },
  dependencies: [
    activeContextsProvider,
  ],
);
