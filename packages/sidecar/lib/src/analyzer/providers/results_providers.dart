import 'dart:async';
import 'dart:developer';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../../context/context.dart';
import '../../protocol/protocol.dart';
import '../../server/communication_channel.dart';
import '../../services/file_analyzer_service_impl.dart';
import '../../utils/utils.dart';
import '../context/context.dart';
import '../sidecar_analyzer.dart';
import 'providers.dart';

/// Analyze a Dart file and generate the Element/ASTNode/Type structures.
final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>((ref, file) async {
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;

  final context = ref.watch(_contextForFileProvider(file));
  if (context == null) return null;

  final result = await timedLogAsync('getResolvedUnit',
      () async => context.currentSession.getResolvedUnit(file.path));
  return result as ResolvedUnitResult;
});

final _contextForFileProvider = Provider.family<AnalysisContext?, AnalyzedFile>(
  (ref, file) {
    final contexts = ref.watch(contextCollectionProvider);
    return contexts.contextForRoot(file.contextRoot);
  },
);

final sidecarContextProvider =
    Provider.family<SidecarContext?, AnalyzedFile>((ref, file) {
  final context = ref.watch(_contextForFileProvider(file));
  if (context == null) return null;

  final sidecarSpec = ref.watch(projectSidecarSpecProvider);
  final targetUri = ref.watch(activeTargetRootProvider);

  return SidecarContextImpl(context,
      sidecarSpec: sidecarSpec, data: {}, targetUri: targetUri);
});

// final sidecarContextWithDataProvider =
//     Provider.family<SidecarContext?, AnalyzedFile>((ref, file) {
//   final data = ref.watch(totalDataResultsProvider).value;
//   final context = ref.watch(sidecarContextProvider(file));
//   return context?.copyWith(data: data);
// });

/// Compute and cache lint results for a given file.
final lintResultsProvider =
    FutureProvider.family<Set<LintResult>, AnalyzedFile>((ref, file) async {
  // ref.onDispose(() => ref.invalidate(nodeRegistryForFileLintsProvider));

  final analyzerService = ref.watch(fileAnalyzerServiceProvider);
  final rulesForFile = ref.watch(scopedLintRulesForFileProvider(file));
  final registry = ref.watch(nodeRegistryForFileLintsProvider(file));

  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);

  return timedLog('visitLintResults', () {
    return runZonedGuarded<Set<LintResult>>(
          () {
            final results =
                analyzerService.visitLintResults(unit, rulesForFile, registry);
            return results;
          },
          (err, stk) {
            assert(false, '${err.toString()} ${stk.toString()}');
            log('lintResultsProvider', error: err, stackTrace: stk);
          },
        ) ??
        {};
  });
});

/// Locate all QuickAssist nodes for which code edits can be calculated from.
///
/// As opposed to the AssistResults, which are calculated on-demand based on
/// an IDE client's cursor offset/length, AssistFilters are outputs of an
/// ASTNode scan which is generated pro-actively.
final assistFiltersProvider =
    FutureProvider.family<Set<AssistFilterResult>, AnalyzedFile>(
        (ref, file) async {
  // ref.onDispose(() => ref.invalidate(nodeRegistryForFileAssistsProvider));

  final rules = ref.watch(scopedAssistRulesForFileProvider(file));
  final analyzerService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeRegistryForFileAssistsProvider(file));

  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);

  return runZonedGuarded<Set<AssistFilterResult>>(
        () => analyzerService.visitAssistFilters(unit, rules, registry),
        (err, stk) => log('assistFiltersProvider', error: err, stackTrace: stk),
      ) ??
      {};
});

/// Compute all quick fixes from applicable Lint results.
final quickFixResultsProvider =
    FutureProvider.family<List<LintResultWithEdits>, AnalyzedFile>(
        (ref, file) async {
  final lints = ref.watch(lintResultsProvider(file).select((v) => v.value));
  final resultsWithFixes = lints?.where((e) => e.editsComputer != null);

  final computedResults =
      await Future.wait<LintResultWithEdits>(resultsWithFixes?.map((e) async {
            final edits = await e.editsComputer!();
            return e.copyWithEdits(edits: edits);
          }) ??
          []);
  return computedResults;
});

/// Compute all data results from applicable results.
final dataResultsProvider =
    Provider.family<Set<SingleDataResult<Object>>, AnalyzedFile>((ref, file) {
  final analyzerService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeRegistryForFileDataProvider(file));
  final rulesForFile = ref.watch(scopedDataRulesForFileProvider(file));

  final unit = ref.watch(resolvedUnitForFileProvider(file));
  return timedLog('visitDataResults', () {
    return runZonedGuarded<Set<SingleDataResult<Object>>>(
          () => analyzerService.visitDataResults(
              unit.valueOrNull, rulesForFile, registry),
          (err, stk) {
            assert(false, '${err.toString()} ${stk.toString()}');
            log('dataResultsProvider', error: err, stackTrace: stk);
          },
        ) ??
        {};
  });
});

final totalDataResultsProvider = Provider<Set<TotalData<dynamic>>>((ref) {
  final files = ref.watch(activeProjectScopedFilesProvider);
  final allDataResults = <SingleDataResult<Object>>[];

  for (final file in files) {
    final data = ref.watch(dataResultsProvider(file));
    allDataResults.addAll(data);
  }
  final totalDataResults = <TotalData<Object>>{};

  for (final dataRule in allDataResults.map((e) => e.code).toSet()) {
    final totalData = allDataResults.where((r) => r.code == dataRule);
    totalDataResults
        .add(TotalData<Object>(code: dataRule, data: totalData.toSet()));
  }
  return totalDataResults;
});

final lintListener = Provider((ref) {
  final files = ref.watch(activeProjectScopedFilesProvider);
  final channel = ref.watch(communicationChannelProvider);
  for (final file in files) {
    ref.listen<Set<LintResult>?>(
        lintResultsProvider(file).select((data) => data.valueOrNull),
        (_, lints) {
      channel.sendNotification(LintNotification(file, lints ?? {}));
    });
  }
});
