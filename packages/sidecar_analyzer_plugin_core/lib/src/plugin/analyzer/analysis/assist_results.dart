import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../protocol/protocol.dart';
import '../analyzer.dart';

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
});
