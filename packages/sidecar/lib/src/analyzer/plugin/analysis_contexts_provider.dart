import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../configurations/configurations.dart';
import '../../protocol/models/models.dart';
import '../../services/active_project_service.dart';
import '../../services/services.dart';
import '../../utils/file_paths.dart';
import '../context/active_context.dart';
import '../context/context.dart';
import '../results/analysis_results_provider.dart';
import 'analyzer_resource_provider.dart';

part 'analysis_contexts_provider.g.dart';

@Riverpod(keepAlive: true)
class AllContextsNotifier extends _$AllContextsNotifier {
  @override
  List<AnalysisContext> build() {
    return [];
  }

  void update(AnalysisContextCollection collection) {
    final config = ref.watch(activeContextNotifierProvider
        .select((value) => value?.packageConfigJson));
    assert(config != null, 'active context should have been set by now');

    state = collection.contexts
        .where((context) => config!.packages
            .any((package) => package.root == context.contextRoot.root.toUri()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
class ActiveContextNotifier extends _$ActiveContextNotifier {
  @override
  ActiveContext? build() {
    return null;
  }

  void updateRoot(Uri root) {
    final service = ref.watch(activeProjectServiceProvider);
    final resourceProvider = ref.watch(analyzerResourceProvider);
    final activeContext = service.initActiveContextFromUri(root,
        resourceProvider: resourceProvider);
    assert(activeContext != null,
        'ActiveContext was not found at root: ${root.path}');
    // final context = Context(root: activeContext!.activeRoot.root.toUri());
    // _listenToConfigForChanges(ref, context);
    state = activeContext;
  }

  void updateConfig() {
    final activeProjectService = ref.watch(activeProjectServiceProvider);
    final newConfig =
        activeProjectService.getSidecarOptions(state!.activeRoot.root.toUri());
    if (newConfig == null) {
      throw UnimplementedError('updateConfig expected config');
    }
    state = state!.copyWith(sidecarOptions: newConfig);
  }
}

@Riverpod(keepAlive: true)
AnalysisContext analysisContextForRoot(
  AnalysisContextForRootRef ref,
  Context context,
) {
  final subscription = _listenToConfigForChanges(ref, context);
  ref.onDispose(() => subscription?.cancel());
  final allContexts = ref.watch(allContextsNotifierProvider);
  return allContexts.firstWhere((analysisContext) =>
      analysisContext.contextRoot.root.toUri() == context.root);
}

StreamSubscription? _listenToConfigForChanges(
  Ref ref,
  Context context,
) {
  final path = p.join(context.root.path, kSidecarYaml);
  final resourceProvider = ref.watch(analyzerResourceProvider);
  final file = resourceProvider.getFile(path);
  if (!file.exists) return null;
  final resourceWatcher = file.watch();
  return resourceWatcher.changes.listen((event) {
    // if (event.type != ChangeType.REMOVE) {
    ref.read(activeContextNotifierProvider.notifier).updateConfig();
    // ref.invalidate(analysisContextForRootProvider);
    // ref.invalidate(activeContextsProvider);
    // ref.invalidate(activeContextDependenciesForRootProvider(root));
    // ref.invalidate(activatedRulesProvider);
    // for (final file in root.typedAnalyzedFiles()) {
    //   ref.invalidate(analysisResultsForFileProvider(file));
    //   ref.refresh(analysisResultsReporterProvider(file));
    // }
    // }
  });
}
