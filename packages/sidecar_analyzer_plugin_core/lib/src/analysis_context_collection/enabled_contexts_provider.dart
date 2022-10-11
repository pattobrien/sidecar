import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/sidecar.dart';

import '../analyzed_file/analyzed_file.dart';
import '../services/log_delegate/log_delegate_base.dart';
import '../services/project_configuration_service/project_configuration.dart';
import 'analysis_context_collection_notifier.dart';

final contextRootsProvider = Provider<List<ContextRoot>>(
  (ref) {
    final collection = ref.watch(analysisContextsProvider);
    return collection.map((e) => e.contextRoot).toList();
  },
  dependencies: [analysisContextsProvider],
);

final enabledContextsProvider = FutureProvider<List<AnalysisContext>>(
  (ref) async {
    final contexts = ref.watch(analysisContextsProvider);
    final results =
        await Future.wait<Map<AnalysisContext, ProjectConfiguration?>>(
            contexts.map((context) async {
      final config = await ref
          .read(projectConfigurationProvider(context.contextRoot).future);
      // return config != null;
      return <AnalysisContext, ProjectConfiguration?>{context: config};
    })).then((value) {
      final mappedValue = <AnalysisContext, ProjectConfiguration?>{};
      value.forEach(mappedValue.addAll);
      return mappedValue;
    })
          ..removeWhere((key, value) {
            return !key.isSidecarEnabled || value == null;
          });
    return results.keys.toList();
  },
  dependencies: [
    analysisContextsProvider,
    projectConfigurationProvider,
  ],
);

final enabledContextProvider =
    FutureProvider.family<AnalysisContext, AnalyzedFile>(
  (ref, analyzedFile) async {
    final contexts = await ref.watch(enabledContextsProvider.future);
    try {
      return contexts.firstWhere((context) {
        return context.contextRoot.isAnalyzed(analyzedFile.path);
      });
    } catch (e, stackTrace) {
      ref.read(logDelegateProvider).sidecarError(
          'NON-FATAL ERROR: ${contexts.length} contexts (${contexts.first.contextRoot.root}) // file ${analyzedFile.relativePath} ${e.toString()}',
          stackTrace);
      // return null;
      rethrow;
    }
  },
  dependencies: [enabledContextsProvider],
);
