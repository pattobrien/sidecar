import 'package:riverpod/riverpod.dart';

import '../../services/services.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';
import 'results.dart';

final assistResultsProvider =
    FutureProvider.family<List<AnalysisResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final activatedRules = ref.watch(lintRulesForFileProvider(file));

    final unitResult = await ref.watch(resolvedUnitProvider(file).future);

    final results = await fileService.computeAnalysisResults(
      file: file,
      activatedRules: activatedRules,
      unitResult: unitResult,
    );
    return [];
  },
  dependencies: [
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);
