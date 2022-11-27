import 'dart:async';
import 'dart:developer';

import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/file_analyzer_service_impl.dart';
import 'plugin.dart';
import 'resolved_unit_provider.dart';

//
const proactiveAssistFilter = true;
const proactiveFixComputes = true;

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

final lintResultsProvider =
    FutureProvider.family<Set<LintResult>, AnalyzedFile>((ref, file) async {
  ref.onDispose(() {
    // ref.invalidate(resolvedUnitForFileProvider(file));

    print('ONDISPOSE EVENT ${file.relativePath}');
  });
  ref.onCancel(() {
    print('ONCANCEL EVENT ${file.relativePath}');
  });
  // ref.onDispose(() => ref.invalidate(registryVisitorProvider(file)));
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
  final registry = ref.watch(nodeLintRegistryForFileAssistsProvider(file));
  final rulesForFile = ref.watch(scopedLintRulesForFileProvider(file));
  print('rulesForFile: ${rulesForFile.map((e) => e.code)}');

  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);
  return runZonedGuarded<Set<LintResult>>(
        () => analyzerService.visitLintResults(
            unitResult: unit, rules: rulesForFile, registry: registry),
        (error, stack) => log('lintResultsProvider error',
            error: error, stackTrace: stack, name: 'lintResults'),
      ) ??
      {};
});

final lintResultsCompleterProvider = FutureProvider((ref) async {
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
    .autoDispose<Set<AssistFilterResult>, AnalyzedFile>((ref, file) async {
  final rules = ref.watch(scopedAssistRulesForFileProvider(file));
  final analyzerService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeAssistRegistryForFileAssistsProvider(file));
  // print('REGISTRY ${registry}');
  print('ASSIST FILTERS RULES: ${rules.length}');
  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);

  return runZonedGuarded<Set<AssistFilterResult>>(
        () {
          final results = analyzerService.visitAssistFilters(
              unitResult: unit, rules: rules, registry: registry);
          print('ASSIST FILTERS RESULTS: ${results.length}');
          return results;
        },
        (error, stack) => log('lintResultsProvider error',
            error: error, stackTrace: stack, name: 'lintResults'),
      ) ??
      {};
});

// lastly, we can calculate the things that are lowest priority, compared to lints

// final assistResultsProvider = FutureProvider.family
//     .autoDispose<Set<AssistResultWithEdits>, AnalyzedFile>((ref, file) async {
//   // for a given filter result, compute the applicable source changes
//   final assistFilterResults =
//       await ref.watch(assistFiltersProvider(file).future);
//   print('ASSIST FILTERREESULTS ${assistFilterResults.length}');
//   print(
//       'ASSIST FILTERREESULTS SAME CODE ${assistFilterResults.map((e) => e.rule.code)}');
//   final resultsWithFixes =
//       assistFilterResults.where((element) => element.editsComputer != null);
//   print('ASSIST resultsWithFixes ${resultsWithFixes.length}');
//   final results = await Future.wait(resultsWithFixes.map((e) async {
//     final edits = await e.editsComputer!();
//     return AssistResultWithEdits(code: e.rule, span: e.span, edits: edits);
//   }));
//   return results.toSet();
// });

final quickFixResultsProvider = FutureProvider.family
    .autoDispose<List<LintResultWithEdits>, AnalyzedFile>((ref, file) async {
  // calculate the quick fixes from the lint result
  // final analyzer = ref.watch(fileAnalyzerServiceProvider);
  // await ref.watch(lintResultsCompleterProvider.future);
  final lintResults = await ref.watch(lintResultsProvider(file).future);
  final resultsWithFixes =
      lintResults.where((element) => element.editsComputer != null);
  final results = await Future.wait(resultsWithFixes.map((e) async {
    final edits = await e.editsComputer!();
    return e.copyWithEdits(edits: edits);
  }));
  return results;
  // calculate edits
});
