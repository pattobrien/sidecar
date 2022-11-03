import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../configurations/configurations.dart';
import '../../protocol/protocol.dart';
import '../../services/services.dart';
import '../../utils/duration_ext.dart';
import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin_resource_provider.dart';
import '../plugin/rules.dart';
import 'results.dart';

part 'analysis_results_provider.g.dart';

@riverpod
Future<List<LintResult>> analysisResultsForFile(
  AnalysisResultsForFileRef ref,
  AnalyzedFile file,
) async {
  final fileService = ref.watch(fileAnalyzerServiceProvider);
  final rules = ref.watch(lintRulesForFileProvider(file));
  final unit = await ref.watch(getResolvedUnitForFileProvider(file).future);

  final watch = Stopwatch()..start();
  if (file.isSidecarYamlFile) {
    final resourceProvider = ref.watch(analyzerResourceProvider);
    final content = resourceProvider.getFile(file.path).readAsStringSync();
    final config = ProjectConfiguration.fromYaml(content, fileUri: unit!.uri);
    return config.allErrors.map((e) => e.toLintResult()).toList();
  } else {
    final results = await fileService.computeLintResults(
        file: file, rules: rules, unitResult: unit);
    final elapsedTime = watch.elapsed.prettified();
    logger.info('analysisResults in: $elapsedTime - ${file.relativePath}');
    return results;
  }
}

@riverpod
Future<List<LintResult>> lintResultsForFile(
  LintResultsForFileRef ref,
  AnalyzedFile file,
) async {
  final results = await ref.watch(analysisResultsForFileProvider(file).future);
  return results.whereType<LintResult>().toList();
}

@riverpod
Future<List<LintResult>> lintResultsForRoot(
  LintResultsForRootRef ref,
  ActiveContextRoot root,
) async {
  final results = await Future.wait(root
      .analyzedFiles()
      .map((file) async => ref.watch(lintResultsForFileProvider(file).future)));
  return results.expand((e) => e).toList();
}

// final analysisResultsCompletedForContextProvider =
//     Provider.family<bool, ActiveContextRoot>(
//   (ref, root) => root.typedAnalyzedFiles().every(
//       (file) => ref.watch(analysisResultsForFileProvider(file)).hasValue),
//   name: 'analysisResultsCompletedForContextProvider',
//   dependencies: [
//     analysisResultsForFileProvider,
//   ],
// );

@riverpod
List<AnalysisResult> analysisResultsForContext(
  AnalysisResultsForContextRef ref,
  ActiveContextRoot root,
) {
  final analyzedFiles = root.analyzedFiles();
  final analysisResults = analyzedFiles.map((file) =>
      ref.watch(analysisResultsForFileProvider(file)).valueOrNull ?? []);
  return analysisResults.expand((e) => e).toList();
}
