import 'package:riverpod/riverpod.dart';

import '../../configurations/configurations.dart';
import '../../services/services.dart';
import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin_resource_provider.dart';
import '../plugin/rules.dart';
import 'results.dart';

final analysisResultsForFileProvider =
    FutureProvider.family<List<AnalysisResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final activatedRules = ref.watch(lintRulesForFileProvider(file));

    final unit = await ref.watch(resolvedUnitProvider(file).future);

    if (file.isSidecarYamlFile) {
      final config = ProjectConfiguration.parseFromSidecarYaml(unit!.content,
          sourceUrl: unit.uri);
      ref
          .watch(logDelegateProvider)
          .sidecarMessage('SIDECAR CONFIG = ${unit.content}');
      final resourceProvider = ref.watch(pluginResourceProvider);
      final content = resourceProvider.getFile(file.path).readAsStringSync();
      ref
          .watch(logDelegateProvider)
          .sidecarMessage('SIDECAR CONFIG UPDATED = $content');
      return config.sourceErrors.map((e) => e.toAnalysisResult()).toList();
    } else {
      return fileService.computeAnalysisResults(
          file: file, activatedRules: activatedRules, unitResult: unit);
      // TODO: make sending results a separate provider
      // ref.watch(logDelegateProvider).analysisResults(file.path, results);
    }
  },
  name: 'analysisResultsForFileProvider',
  dependencies: [
    // logDelegateProvider,
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);

final analysisResultsCompletedForContextProvider =
    Provider.family<bool, ActiveContextRoot>(
  (ref, root) {
    return root.typedAnalyzedFiles().every(
        (file) => ref.watch(analysisResultsForFileProvider(file)).hasValue);
  },
  name: 'analysisResultsCompletedForContextProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);

final analysisResultsForContextProvider =
    Provider.family<List<AnalysisResult>, ActiveContextRoot>(
  (ref, root) {
    final analyzedFiles = root.typedAnalyzedFiles();
    final results = analyzedFiles.map((file) =>
        ref.watch(analysisResultsForFileProvider(file)).valueOrNull ?? []);
    return results.expand((e) => e).toList();
  },
  name: 'analysisResultsForContextProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);
