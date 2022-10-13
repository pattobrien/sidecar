// ignore_for_file: implementation_imports

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../active_contexts/active_contexts.dart';
import 'isolate_builder_service.dart';
import 'isolate_details.dart';

final isolateDetailForContextProvider =
    Provider.family<IsolateDetails, ActiveContextRoot>(
  (ref, activeRoot) {
    final isolateService = ref.watch(isolateBuilderServiceProvider);

    ref.onDispose(() => isolateService.shutdownIsolate(ref.state));

    ref.listen<ActiveContext>(
        activeContextsProvider.select((activeContexts) => activeContexts
            .firstWhere((context) => context.activeRoot == activeRoot)),
        (previous, next) {
      // will rebuild any time the plugin package updates
      if (previous == null) return;

      if (previous.sidecarPluginPackage != next.sidecarPluginPackage) {
        isolateService.shutdownIsolate(ref.state);
        ref.invalidateSelf();
      }
    });

    final pluginSourceUri =
        ref.watch(contextSidecarPluginPackageProvider(activeRoot))!;
    final packages = ref.watch(contextSidecarDependenciesProvider(activeRoot));

    return isolateService.startIsolate(
      //TODO: change startIsolate to accept package
      pluginSourceUri.root,
      activeRoot,
      packages,
    );
  },
  dependencies: [
    contextSidecarDependenciesProvider,
    activeContextsProvider,
    isolateBuilderServiceProvider,
    contextSidecarPluginPackageProvider,
  ],
);



// final isolateDetailsForContextRootProvider = Provider.autoDispose
//     .family<IsolateDetails, ActiveContextRoot>((ref, contextRoot) {
//   final isolateService = ref.watch(isolateBuilderServiceProvider);

//   final uri = ref.watch<Uri>(activePluginUriProvider(contextRoot));
//   ref.onDispose(() {
//     isolateService.shutdownIsolate(ref.state);
//   });

//   // listen for added/removed sidecar lint packages
//   ref.listen<List<SidecarPackage>>(
//       contextSidecarDependenciesProvider(contextRoot), (_, packages) {
//     ref.state = isolateService.updatePackages(ref.state, packages);
//   });

//   return isolateService.updateUri(ref.state, uri);

//   // if (ref.state != null) {
//   //   return isolateService.updateUri(ref.state!, uri);
//   // } else {
//   //   final packages = ref.watch(activeSidecarDependenciesProvider(contextRoot));
//   //   return isolateService.startIsolate(uri, contextRoot, packages);
//   // }
// }, dependencies: [
//   activePluginUriProvider,
//   contextSidecarDependenciesProvider,
//   isolateBuilderServiceProvider,
// ]);

// final isolateDetailsProvider = Provider<List<IsolateDetails>>((ref) {
// final activeContexts = ref.watch(activeContextRootsProvider);
// final isolateService = ref.watch(isolateBuilderServiceProvider);
// ref.onDispose(() {
//   isolateService.shutdownIsolate(ref.state);
// });

// return activeContexts.map((e) => isolateService.updatePackages(ref.state, packages)).toList();
// });