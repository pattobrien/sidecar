import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';
import '../active_contexts/active_contexts.dart';
import 'isolates.dart';

final isolateDetailsProvider = Provider<List<IsolateDetails>>(
  (ref) {
    final isolateService = ref.watch(isolateBuilderServiceProvider);
    final isolateCommunication = ref.watch(isolateCommunicationServiceProvider);
    ref.listenSelf((previous, next) {
      final changedIsolates = next.where(
          (isolate) => previous?.any((element) => isolate != element) ?? true);
      changedIsolates.forEach(isolateCommunication.addIsolateListener);
    });
    final activeContexts = ref.watch(activeContextsProvider);
    final isolates = activeContexts.map(isolateService.startIsolate).toList();
    return isolates;
    // return activeContextRoots.map((activeRoot) {
    //   final isolate =
    //       ref.state.firstWhere((details) => details.activeRoot == activeRoot);

    //   ref.onDispose(() => isolateService.shutdownIsolate(isolate));

    //   ref.listen<ActiveContext>(activeContextForContextRootProvider(activeRoot),
    //       (prev, next) {
    //     // will rebuild any time the plugin package updates
    //     if (prev == null) return;
    //     final didChange =
    //         prev.sidecarPluginPackage != next.sidecarPluginPackage ||
    //             prev.sidecarPackages != next.sidecarPackages;
    //     if (didChange) {
    //       isolateService.shutdownIsolate(isolate);
    //       ref.invalidateSelf();
    //     }
    //   });

    //   final context =
    //       ref.watch(activeContextForContextRootProvider(activeRoot));
    //   return isolateService.startIsolate(context);
    // }).toList();
  },
  name: 'isolateDetailsProvider',
  dependencies: [
    activeContextRootsProvider,
    isolateBuilderServiceProvider,
    activeContextForContextRootProvider,
  ],
);

// final isolateDetailForContextProvider =
//     Provider.family<IsolateDetails, ActiveContextRoot>(
//   (ref, activeRoot) {
//     final isolateService = ref.watch(isolateBuilderServiceProvider);

//     ref.onDispose(() => isolateService.shutdownIsolate(ref.state));

//     ref.listen<ActiveContext>(activeContextForContextRootProvider(activeRoot),
//         (prev, next) {
//       // will rebuild any time the plugin package updates
//       if (prev == null) return;
//       final didChange =
//           prev.sidecarPluginPackage != next.sidecarPluginPackage ||
//               prev.sidecarPackages != next.sidecarPackages;
//       if (didChange) {
//         isolateService.shutdownIsolate(ref.state);
//         ref.invalidateSelf();
//       }
//     });

//     final context = ref.watch(activeContextForContextRootProvider(activeRoot));
//     return isolateService.startIsolate(context);
//   },
//   dependencies: [
//     contextSidecarDependenciesProvider,
//     activeContextForContextRootProvider,
//     isolateBuilderServiceProvider,
//   ],
// );