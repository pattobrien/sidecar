import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/services.dart';
import '../../utils/file_paths.dart';
import '../context/context.dart';
import '../results/results.dart';
import 'plugin.dart';
import 'sidecar_analyzer.dart';

// part 'active_contexts_provider.g.dart';

// @Riverpod(keepAlive: true)

// List<ActiveContext> activeContexts(
//   ActiveContextsRef ref,
//   // SidecarAnalyzer analyzer,
// ) {
//   final service = ref.watch(activeProjectServiceProvider);
//   final allContexts =
//       ref.watch<List<AnalysisContext>>(allContextsNotifierProvider);
//   final contexts =
//       allContexts.map(service.getActiveContext).whereType<ActiveContext>();

//   final dependencies = contexts
//       .map((e) => service.getActiveDependencies(e, allContexts))
//       .expand((e) => e);

//   logger.finer('# of all contexts => ${allContexts.length} ');
//   logger.finer('# of active contexts => ${contexts.length} ');
//   for (final activeContext in contexts) {
//     logger.finer('active context => ${activeContext.activeRoot.root.path}');
//   }
//   final activeContextsAndDependencies = [...contexts, ...dependencies];
//   assert(
//       activeContextsAndDependencies
//               .where((c) => c.isExplicitlyEnabled)
//               .length ==
//           1,
//       'There should only ever be 1 main active context for each isolate.');

//   return activeContextsAndDependencies;
// }

// @Riverpod(keepAlive: true)
// ActiveContext activeContextForRoot(
//   ActiveContextForRootRef ref,
//   ActiveContextRoot root,
// ) {
//   final configSub = _listenToConfigForChanges(ref, root);
//   ref.onDispose(() => configSub?.cancel());
//   return ref.watch(activeContextsProvider.select((activeContexts) =>
//       activeContexts.firstWhere((activeContext) =>
//           activeContext.activeRoot.root.path == root.root.path)));
// }

// @Riverpod(keepAlive: true)
// List<ActiveContextRoot> activeContextRoots(
//   ActiveContextRootsRef ref,
//   // SidecarAnalyzer analyzer,
// ) {
//   return ref.watch(activeContextsProvider).map((e) => e.activeRoot).toList();
// }

// StreamSubscription? _listenToConfigForChanges(
//   Ref ref,
//   ActiveContextRoot root,
// ) {
//   final sidecarConfigPath = p.join(root.root.path, kSidecarYaml);
//   final sidecarConfigFile = root.resourceProvider.getFile(sidecarConfigPath);
//   if (!sidecarConfigFile.exists) return null;

//   final resourceWatcher = sidecarConfigFile.watch();
//   return resourceWatcher.changes.listen((event) {
//     ref.invalidate(activeContextNotifierProvider);
//     ref.invalidate(activatedRulesForRootProvider(root));
//     for (final file in root.analyzedFiles()) {
//       ref.invalidate(analysisResultsForFileProvider(file));
//       ref.refresh(createAnalysisReportProvider(file));
//     }
//   });
// }
