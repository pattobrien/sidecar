import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sidecar/src/analyzer/results/analysis_results_reporter.dart';

import '../../protocol/analyzer_plugin_exts/analyzer_plugin_exts.dart';
import '../../protocol/models/models.dart';
import '../../services/active_project_service.dart';
import '../../services/services.dart';
import '../../utils/file_paths.dart';
import '../context/active_context.dart';
import '../context/context.dart';
import '../results/analysis_results_provider.dart';
import 'analyzer_resource_provider.dart';
import 'rules.dart';

part 'analysis_contexts_provider.g.dart';

final rootUriProvider = Provider<Uri>((ref) => Uri());

@Riverpod(keepAlive: true)
class AllContextsNotifier extends _$AllContextsNotifier {
  @override
  List<AnalysisContext> build() {
    return [];
  }

  void update(AnalysisContextCollection collection) {
    final config = ref.watch(activeContextNotifierProvider
        .select((value) => value.packageConfigJson));

    state = collection.contexts
        .where((context) => config.packages
            .any((package) => package.root == context.contextRoot.root.toUri()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
class ActiveContextNotifier extends _$ActiveContextNotifier {
  @override
  ActiveContext build() {
    final root = ref.watch(rootUriProvider);
    final service = ref.watch(activeProjectServiceProvider);
    final resourceProvider = ref.watch(analyzerResourceProvider);
    final activeContext = service.initActiveContextFromUri(root,
        resourceProvider: resourceProvider);
    return activeContext!;
  }

  void updateConfig() {
    final activeProjectService = ref.watch(activeProjectServiceProvider);
    final newConfig =
        activeProjectService.getSidecarOptions(state.activeRoot.root.toUri());
    if (newConfig == null) {
      throw UnimplementedError('updateConfig expected config');
    }
    state = state.copyWith(sidecarOptions: newConfig);
  }
}

@Riverpod(keepAlive: true)
AnalysisContext analysisContextForRoot(
  AnalysisContextForRootRef ref,
  Context context,
) {
  final subscription = _listenToConfigForChanges(ref, context);
  ref.onDispose(() => subscription?.cancel());
  return ref.watch(allContextsNotifierProvider.select((value) =>
      value.firstWhere((analysisContext) =>
          analysisContext.contextRoot.root.toUri() == context.root)));
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
    final activeContext = ref.read(activeContextNotifierProvider);

    // ref.invalidate(analysisContextForRootProvider);
    // ref.invalidate(activeContextsProvider);
    ref.invalidate(filteredRulesForFileProvider);
    ref.invalidate(activatedRulesForRootProvider);
    for (final file in activeContext.context.typedAnalyzedFiles()) {
      ref.invalidate(analysisResultsForFileProvider(file));
      ref.refresh(createAnalysisReportProvider(file).future);
      // ref.read(createAnalysisReportProvider(file).future);
      // ref.read(analysisResultsForFileProvider(file).future);
      // ref.read(createAnalysisReportProvider(file));
    }
    // }
  });
}
