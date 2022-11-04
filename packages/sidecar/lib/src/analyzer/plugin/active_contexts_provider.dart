import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/services.dart';
import '../../utils/file_paths.dart';
import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../results/results.dart';
import 'plugin.dart';
import 'sidecar_analyzer.dart';

part 'active_contexts_provider.g.dart';

@riverpod
List<ActiveContext> activeContexts(
  ActiveContextsRef ref,
  // SidecarAnalyzer analyzer,
) {
  final service = ref.watch(activeProjectServiceProvider);
  final allContexts =
      ref.watch<List<AnalysisContext>>(allContextsNotifierProvider);
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
  assert(
      activeContextsAndDependencies
              .where((c) => c.isExplicitlyEnabled)
              .length ==
          1,
      'There should only ever be 1 main active context for each isolate.');

  return activeContextsAndDependencies;
}

@riverpod
ActiveContext activeContextForRoot(
  ActiveContextForRootRef ref,
  ActiveContextRoot root,
) {
  final configSub = _listenToConfigForChanges(ref, root);
  ref.onDispose(() => configSub?.cancel());
  return ref.watch(activeContextsProvider.select((activeContexts) =>
      activeContexts.firstWhere((activeContext) =>
          activeContext.activeRoot.root.path == root.root.path)));
}

@riverpod
List<ActiveContextRoot> activeContextRoots(
  ActiveContextRootsRef ref,
  SidecarAnalyzer analyzer,
) {
  return ref.watch(activeContextsProvider).map((e) => e.activeRoot).toList();
}

StreamSubscription? _listenToConfigForChanges(
  Ref ref,
  ActiveContextRoot root,
) {
  final sidecarConfigPath = p.join(root.root.path, kSidecarYaml);
  final sidecarConfigFile = root.resourceProvider.getFile(sidecarConfigPath);
  if (!sidecarConfigFile.exists) return null;

  final resourceWatcher = sidecarConfigFile.watch();
  return resourceWatcher.changes.listen((event) {
    ref.invalidate(activeContextsProvider);
    ref.invalidate(activeContextForRootProvider(root));
    ref.invalidate(activatedRulesForRootProvider(root));
    for (final file in root.analyzedFiles()) {
      ref.invalidate(analysisResultsForFileProvider(file));
      ref.refresh(createAnalysisReportProvider(file));
    }
  });
}
