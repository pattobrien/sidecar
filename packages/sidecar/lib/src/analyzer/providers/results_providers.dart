import 'dart:async';
import 'dart:developer';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/file_analyzer_service_impl.dart';
import '../../utils/utils.dart';
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

/// Compute and cache lint results for a given file.
final lintResultsProvider =
    FutureProvider.family<Set<LintResult>, AnalyzedFile>((ref, file) async {
  final analyzerService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeRegistryForFileLintsProvider(file));
  final rulesForFile = ref.watch(scopedLintRulesForFileProvider(file));

  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);
  return timedLog(
      'visitLintResults',
      () =>
          runZonedGuarded<Set<LintResult>>(
            () => analyzerService.visitLintResults(
                unitResult: unit, rules: rulesForFile, registry: registry),
            (error, stack) => log('lintResultsProvider error',
                error: error, stackTrace: stack, name: 'lintResults'),
          ) ??
          {});
});

/// Locate all QuickAssist nodes for which code edits can be calculated from.
///
/// As opposed to the AssistResults, which are calculated on-demand based on
/// an IDE client's cursor offset/length, AssistFilters are outputs of an
/// ASTNode scan which is generated pro-actively.
final assistFiltersProvider = FutureProvider.family
    .autoDispose<Set<AssistFilterResult>, AnalyzedFile>((ref, file) async {
  final rules = ref.watch(scopedAssistRulesForFileProvider(file));
  final analyzerService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeRegistryForFileAssistsProvider(file));
  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);

  return runZonedGuarded<Set<AssistFilterResult>>(
        () {
          final results = analyzerService.visitAssistFilters(
              unitResult: unit, rules: rules, registry: registry);
          return results;
        },
        (error, stack) => log('lintResultsProvider error',
            error: error, stackTrace: stack, name: 'lintResults'),
      ) ??
      {};
});

/// Compute all quick fixes from applicable Lint results.
final quickFixResultsProvider = FutureProvider.family
    .autoDispose<List<LintResultWithEdits>, AnalyzedFile>((ref, file) async {
  // await ref.watch(lintResultsCompleterProvider.future);
  final lintResults = await ref.watch(lintResultsProvider(file).future);
  final resultsWithFixes =
      lintResults.where((element) => element.editsComputer != null);
  return Future.wait(resultsWithFixes.map((e) async {
    final edits = await e.editsComputer!();
    return e.copyWithEdits(edits: edits);
  }));
});

// final annotationResultsProvider = Provider.autoDispose((ref) {
//   //TODO: what if an annotation is in a file thats outside the project scope?
//   // do we still not want to analyze those files for metadata?
//   final scopedFiles = ref.watch(activeProjectScopedFilesProvider);
//   return scopedFiles
//       .map((file) {
//         final unit = ref.watch(resolvedUnitForFileProvider(file)).valueOrNull;
//         final visitor = AnnotationVisitor();
//         unit?.unit.accept(visitor);
//         return visitor.annotatedNodes;
//       })
//       .expand((e) => e)
//       .toList();
// });
