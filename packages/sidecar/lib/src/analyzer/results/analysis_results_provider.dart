import 'package:riverpod/riverpod.dart';

import '../../configurations/configurations.dart';
import '../../services/services.dart';
import '../../utils/duration_ext.dart';
import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin_resource_provider.dart';
import '../plugin/rules.dart';
import 'results.dart';

final analysisResultsForFileProvider =
    FutureProvider.family<List<AnalysisResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final rules = ref.watch(lintRulesForFileProvider(file));
    final unit = await ref.watch(resolvedUnitProvider(file).future);

    final watch = Stopwatch()..start();
    if (file.isSidecarYamlFile) {
      final resourceProvider = ref.watch(pluginResourceProvider);
      final content = resourceProvider.getFile(file.path).readAsStringSync();
      final config = ProjectConfiguration.fromYaml(content, fileUri: unit!.uri);
      return config.allErrors.map((e) => e.toAnalysisResult()).toList();
    } else {
      final results = await fileService.computeLintResults(
          file: file, rules: rules, unitResult: unit);
      final elapsedTime = watch.elapsed.prettified();
      logger.info('analysisResults in: $elapsedTime - ${file.relativePath}');
      return results;
    }
  },
  name: 'analysisResultsForFileProvider',
  dependencies: [
    pluginResourceProvider,
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);

final lintResultsForFileProvider =
    FutureProvider.family<List<LintResult>, AnalyzedFile>(
  (ref, file) async {
    final results =
        await ref.watch(analysisResultsForFileProvider(file).future);
    return results.whereType<LintResult>().toList();
  },
  name: 'lintResultsForFileProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);

final lintResultsForContextProvider =
    FutureProvider.family<List<LintResult>, ActiveContextRoot>(
  (ref, root) async {
    final results = await Future.wait(root.typedAnalyzedFiles().map(
        (file) async => ref.watch(lintResultsForFileProvider(file).future)));
    return results.expand((e) => e).toList();
  },
  name: 'lintResultsForContextProvider',
  dependencies: [
    lintResultsForFileProvider,
  ],
);

final analysisResultsCompletedForContextProvider =
    Provider.family<bool, ActiveContextRoot>(
  (ref, root) => root.typedAnalyzedFiles().every(
      (file) => ref.watch(analysisResultsForFileProvider(file)).hasValue),
  name: 'analysisResultsCompletedForContextProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);

final analysisResultsForContextProvider =
    Provider.family<List<AnalysisResult>, ActiveContextRoot>(
  (ref, root) {
    final analyzedFiles = root.typedAnalyzedFiles();
    final analysisResults = analyzedFiles.map((file) =>
        ref.watch(analysisResultsForFileProvider(file)).valueOrNull ?? []);
    return analysisResults.expand((e) => e).toList();
  },
  name: 'analysisResultsForContextProvider',
  dependencies: [
    analysisResultsForFileProvider,
  ],
);
