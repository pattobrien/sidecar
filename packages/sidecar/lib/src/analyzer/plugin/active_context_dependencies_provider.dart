import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../services/services.dart';
import '../../utils/file_paths.dart';
import '../context/context.dart';
import '../results/analysis_results_provider.dart';
import '../results/analysis_results_reporter.dart';
import '../server/log_delegate.dart';
import 'plugin.dart';

// final activeContextDependenciesProvider = Provider<List<AnalysisContext>>(
//   (ref) {
//     final activeContexts = ref.watch(activeContextsProvider);
//     return activeContexts
//         .map((e) => e.localDependencyContexts)
//         .expand((e) => e)
//         .toList();
//   },
//   name: 'activeContextDependenciesProvider',
//   dependencies: [
//     activeProjectServiceProvider,
//     allAnalysisContextsProvider,
//   ],
// );

// final activeContextDependencyRootsProvider = Provider<List<ContextRoot>>(
//   (ref) {
//     final activeContextRoots = ref.watch(activeContextRootsProvider);
//     return activeContextRoots
//         .map((e) => e.localDependencyRoots)
//         .expand((e) => e)
//         .toList();
//   },
//   name: 'activeContextDependencyRootsProvider',
//   dependencies: [
//     activeContextsProvider,
//   ],
// );

// final activeContextDependenciesForRootProvider =
//     Provider.family<AnalysisContext, ActiveContextRoot>(
//   (ref, root) {
//     final configSub = _listenToConfigForChanges(ref, root);
//     ref.onDispose(() => configSub?.cancel());
//     return ref.watch(activeContextsProvider.select(
//       (activeContexts) => activeContexts
//           .map((activeContext) => activeContext.localDependencyContexts)
//           .expand((e) => e)
//           .firstWhere((localContext) =>
//               localContext.contextRoot.root.path == root.root.path),
//     ));
//   },
//   name: 'activeContextForContextRootProvider',
//   dependencies: [
//     activeContextsProvider,
//   ],
// );

// StreamSubscription? _listenToConfigForChanges(Ref ref, ActiveContextRoot root) {
//   final path = p.join(root.root.path, kSidecarYaml);
//   final file = root.resourceProvider.getFile(path);
//   if (!file.exists) return null;
//   final resourceWatcher = file.watch();
//   return resourceWatcher.changes.listen((event) {
//     // if (event.type != ChangeType.REMOVE) {
//     ref.invalidate(activeContextsProvider);
//     ref.invalidate(activeContextDependenciesForRootProvider(root));
//     ref.invalidate(activatedRulesProvider);
//     for (final file in root.typedAnalyzedFiles()) {
//       ref.invalidate(analysisResultsForFileProvider(file));
//       ref.refresh(analysisResultsReporterProvider(file));
//     }
//     // }
//   });
// }
