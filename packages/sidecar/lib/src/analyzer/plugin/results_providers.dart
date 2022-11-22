import 'dart:async';
import 'dart:developer';

import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../../protocol/models/analysis_result.dart';
import '../../protocol/models/assist_result.dart';
import '../../services/file_analyzer_service.dart';
import '../ast/general_visitor.dart';
import '../visitors/annotation_visitor.dart';
import 'files_provider.dart';
import 'plugin.dart';
import 'resolved_unit_provider.dart';
import 'scoped_rules_provider.dart';

//
const proactiveAssistFilter = true;
const proactiveFixComputes = true;

final annotationResultsProvider = Provider.autoDispose((ref) {
  //TODO: what if an annotation is in a file thats outside the project scope?
  // do we still not want to analyze those files for metadata?
  final scopedFiles = ref.watch(activeProjectScopedFilesProvider);
  return scopedFiles
      .map((file) {
        final unit = ref.watch(resolvedUnitForFileProvider(file)).valueOrNull;
        final visitor = AnnotationVisitor();
        unit?.unit.accept(visitor);
        return visitor.annotatedNodes;
      })
      .expand((e) => e)
      .toList();
});

final registryVisitorProvider =
    Provider.family<RegisteredLintVisitor, AnalyzedFileWithContext>(
        (ref, file) {
  final registry = ref.watch(nodeRegistryForFileProvider(file));
  return RegisteredLintVisitor(registry);
});

final lintResultsProvider =
    FutureProvider.family<Set<LintResult>, AnalyzedFileWithContext>(
        (ref, file) async {
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
  final visitor = ref.watch(registryVisitorProvider(file));
  final rules = ref.watch(scopedLintRulesForFileProvider(file));
  final visitorRules = ref.watch(scopedVisitorForFileProvider(file));
  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);
  final analyzerService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeRegistryForFileProvider(file));
  return runZonedGuarded<Set<LintResult>>(
        () {
          return analyzerService.visitLintResults(
              unitResult: unit, rules: visitorRules, registry: registry);
          // if (unit == null) return {};
          // for (final visitor in visitors) {
          //   visitor.setUnit(unit);
          // }
          // unit.unit.accept(visitor);
          // return visitor.results;
        },
        (error, stack) {
          log(
            'lintResultsProvider error',
            error: error,
            stackTrace: stack,
            time: DateTime.now(),
            name: 'lintResults',
          );
        },
      ) ??
      {};
});

final lintResultsCompleterProvider = FutureProvider.autoDispose((ref) async {
  final lintResults = ref.container
      .getAllProviderElements()
      .where((base) => base.origin.from == lintResultsProvider)
      .map((e) => e.origin as FutureProvider<Set<LintResult>>);
  print('lintResultsCompleterProvider rebuilding...');
  // we want to await for all lints to be computed before proceeding with any
  // pro-active quick-fix computing
  await Future.wait(lintResults.map((e) async => ref.watch(e.future)));
});

final assistFiltersProvider = FutureProvider.family
    .autoDispose<Set<LintResult>, AnalyzedFileWithContext>((ref, file) async {
  final registry = ref.watch(nodeRegistryForFileProvider(file));
  final visitor = RegisteredLintVisitor(registry);

  await ref.watch(lintResultsCompleterProvider.future);
  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);
  unit?.unit.accept(visitor);
  return visitor.results;
});

// lastly, we can calculate the things that are lowest priority, compared to lints

final assistResultsProvider = FutureProvider.family
    .autoDispose<List<AssistResult>, LintResult>((ref, result) {
  // for a given filter result, compute the applicable source changes
  return [];
});

final quickFixResultsProvider = FutureProvider.family
    .autoDispose<List<LintResultWithEdits>, AnalyzedFileWithContext>(
        (ref, file) async {
  // calculate the quick fixes from the lint result
  final analyzer = ref.watch(fileAnalyzerServiceProvider);
  await ref.watch(lintResultsCompleterProvider.future);
  final lintResults = await ref.watch(lintResultsProvider(file).future);
  // final withFixes = lintResults.map((e) {
  //   analyzer.computeLintResults(file: file, rules: rules, context: context)
  //   e.copyWithEdits(edits: edits)
  //   return ;
  // });
  return [];
  // calculate edits
});
