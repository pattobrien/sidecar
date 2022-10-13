import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../protocol/protocol.dart';
import '../analysis_context_providers.dart';
import 'active_contexts.dart';
import 'context_package_configuration.dart';

/// All contexts properly enabled for Sidecar
///
/// ActiveContexts represent 100% fully initialized contexts, including:
/// - initialized sidecar.yaml configuration
/// - list of all sidecar dependencies
/// - sidecar_analyzer_plugin package information
final activeContextsProvider = Provider<List<ActiveContext>>((ref) {
  final allContexts = ref.watch(allContextsProvider);

  return allContexts
      .map<ActiveContext?>((context) {
        final root = context.contextRoot;
        final projectConfig = ref.watch(projectConfigurationProvider(root));
        final pluginUri = ref.watch(contextSidecarPluginPackageProvider(root));
        final packages = ref.watch(contextSidecarDependenciesProvider(root));

        final isSidecarEnabled = context.isSidecarEnabled;
        final hasProjectConfiguration = projectConfig != null;
        final hasSidecarPlugin = pluginUri != null;
        final hasLintPackages = packages.isNotEmpty;

        if (isSidecarEnabled &&
            hasProjectConfiguration &&
            hasSidecarPlugin &&
            hasLintPackages) {
          return ActiveContext(
            context,
            sidecarOptions: projectConfig,
            sidecarPluginPackage: pluginUri,
            sidecarPackages: packages,
          );
        } else {
          return null;
        }
      })
      .whereType<ActiveContext>()
      .toList();
});

final activeContextRootsProvider = Provider<List<ActiveContextRoot>>((ref) {
  final activeContexts = ref.watch(activeContextsProvider);
  return activeContexts.map((e) => ActiveContextRoot(e.contextRoot)).toList();
});
