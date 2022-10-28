import 'package:riverpod/riverpod.dart';

import '../../protocol/requests/quick_assist_request.dart';
import '../../services/services.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';
import 'results.dart';

final assistResultsForFileProvider =
    FutureProvider.family<List<AssistResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final activatedRules = ref.watch(assistRulesForFileProvider(file));

    final unitResult = await ref.watch(resolvedUnitProvider(file).future);

    return fileService.computeAssistResults(
      file: file,
      rules: activatedRules,
      unitResult: unitResult,
    );
  },
  name: 'assistResultsForFileProvider',
  dependencies: [
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);

final assistResultsWithEditsForFileProvider =
    FutureProvider.family<List<AssistResult>, AnalyzedFile>(
  (ref, file) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final assistResults =
        await ref.watch(assistResultsForFileProvider(file).future);
    final assistResultsWithEdits = await Future.wait(assistResults
        .map((e) async => fileService.calculateAssistResultEdits(e)));
    return assistResultsWithEdits;
  },
  name: 'assistResultsWithEditsForFileProvider',
  dependencies: [
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);

final assistResultsForRequestProvider =
    FutureProvider.family<List<AssistResult>, QuickAssistRequest>(
  (ref, request) async {
    final fileService = ref.watch(fileAnalyzerServiceProvider);
    final assistResults = await ref
        .watch(assistResultsWithEditsForFileProvider(request.file).future);
    return fileService.getAssistResultsAtOffset(assistResults, request);
  },
  name: 'assistResultsForRequestProvider',
  dependencies: [
    lintRulesForFileProvider,
    fileAnalyzerServiceProvider,
    resolvedUnitProvider,
  ],
);
