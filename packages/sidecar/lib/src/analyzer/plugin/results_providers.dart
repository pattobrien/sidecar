import 'dart:async';
import 'dart:developer';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/file_analyzer_service_impl.dart';
import '../../utils/duration_ext.dart';
import '../../utils/logger/logger.dart';
import 'plugin.dart';
import 'resolved_unit_provider.dart';

// ignore: unused_element
const _proactiveAssistFilter = true;
// ignore: unused_element
const _proactiveFixComputes = true;

/// Compute and cache lint results for a given file.
final lintResultsProvider =
    FutureProvider.family<Set<LintResult>, AnalyzedFile>((ref, file) async {
  // ref.onDispose(() => logger.info('ONDISPOSE EVENT ${file.relativePath}'));
  // ref.onCancel(() => logger.info('ONCANCEL EVENT ${file.relativePath}'));

  // benchmark for file: upgrade_options.dart
  // total time: 59.537ms
  //
  // lintResultsProvider subtotal:
  // - get unit: 6.60ms
  // - unit.unit.accept(visitor): 15.5ms
  //
  // append content overlays: ??
  // communication / data transfer: ??

  // - applyPendingFileChanges: 4.61ms

  // services
  final analyzerService = ref.watch(fileAnalyzerServiceProvider);

  // file-dependent objects
  final registry = ref.watch(nodeRegistryForFileLintsProvider(file));
  final rulesForFile = ref.watch(scopedLintRulesForFileProvider(file));
  // logger.info('rulesForFile: ${rulesForFile.map((e) => e.code)}');

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

// final lintResultsCompleterProvider = FutureProvider((ref) async {
//   final lintResults = ref.container
//       .getAllProviderElements()
//       .where((base) => base.origin.from == lintResultsProvider)
//       .map((e) => e.origin as FutureProvider<Set<LintResult>>);
//   logger.info('lintResultsCompleterProvider rebuilding...');
//   // we want to await for all lints to be computed before proceeding with any
//   // pro-active quick-fix computing
//   await Future.wait(lintResults.map((e) async => ref.watch(e.future)));
// });

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
