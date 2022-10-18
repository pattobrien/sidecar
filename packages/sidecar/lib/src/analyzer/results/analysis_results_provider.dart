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
      final resourceProvider = ref.watch(pluginResourceProvider);
      final content = resourceProvider.getFile(file.path).readAsStringSync();

      final config = ProjectConfiguration.parseFromSidecarYaml(content,
          ref: ref, sourceUrl: unit!.uri);

      final errors =
          config.combinedSourceErrors.map((e) => e.toAnalysisResult()).toList();
      return errors;
    } else {
      return fileService.computeAnalysisResults(
          file: file, activatedRules: activatedRules, unitResult: unit);
    }
  },
  name: 'analysisResultsForFileProvider',
  dependencies: [
    logDelegateProvider,
    pluginResourceProvider,
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
