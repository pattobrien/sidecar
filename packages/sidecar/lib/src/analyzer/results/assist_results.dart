import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../protocol/protocol.dart';
import '../../services/services.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';
import 'results.dart';

part 'assist_results.g.dart';

@riverpod
Future<List<AssistResult>> assistResultsForFile(
  AssistResultsForFileRef ref,
  AnalyzedFile file,
) async {
  final fileService = ref.watch(fileAnalyzerServiceProvider);
  final activatedRules = ref.watch(assistRulesForFileProvider(file));

  final unitResult =
      await ref.watch(getResolvedUnitForFileProvider(file).future);

  return fileService.computeAssistResults(
    file: file,
    rules: activatedRules,
    unitResult: unitResult,
  );
}

@riverpod
Future<List<AssistResult>> assistResultsWithEdits(
  AssistResultsWithEditsRef ref,
  AnalyzedFile file,
) async {
  final fileService = ref.watch(fileAnalyzerServiceProvider);
  final rules = ref.watch(assistRulesForFileProvider(file));
  final assistResults =
      await ref.watch(assistResultsForFileProvider(file).future);
  final assistResultsWithEdits = await Future.wait(assistResults.map(
      (e) async =>
          fileService.calculateAssistResultEdits(e, file: file, rules: rules)));
  return assistResultsWithEdits;
}

@riverpod
Future<List<AssistResult>> requestAssistResults(
  RequestAssistResultsRef ref,
  AssistRequest request,
) async {
  final fileService = ref.watch(fileAnalyzerServiceProvider);
  final assistResults =
      await ref.watch(assistResultsWithEditsProvider(request.file).future);
  return fileService.getAssistResultsAtOffset(assistResults, request);
}
