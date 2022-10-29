import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../context/context.dart';
import '../log_delegate.dart';
import '../server.dart';

/// All contexts properly enabled for Sidecar
///
/// ActiveContexts represent 100% fully initialized contexts, including:
/// - initialized sidecar.yaml configuration
/// - list of all sidecar dependencies
/// - sidecar_analyzer_plugin package information
/// - local dependencies of a package that has explicitly enabled Sidecar
final activeContextsMiddlemanProvider = Provider<List<ActiveContext>>(
  (ref) {
    final allContexts = ref.watch(allContextsProvider);
    final log = ref.watch(logDelegateProvider);
    log.sidecarMessage('MM # of all contexts => ${allContexts.length} ');
    final service = ref.watch(activeProjectServiceProvider);
    final mainActiveContexts = allContexts
        .map<ActiveContext?>(service.initializeContext)
        .whereType<ActiveContext>()
        .toList();
    final dependencyContexts = mainActiveContexts
        .map((e) => service.getActiveDependencies(e, allContexts));
    return [...mainActiveContexts, ...dependencyContexts.expand((e) => e)];
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
    return activeContexts.map((context) => context.activeRoot).toList();
  },
  name: 'activeContextRootsProvider',
  dependencies: [
    activeContextsMiddlemanProvider,
  ],
);
