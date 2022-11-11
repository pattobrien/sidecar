// ignore_for_file: dead_code

import 'package:async/async.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../protocol/models/analysis_result.dart';
import '../../protocol/models/assist_result.dart';
import '../../utils/duration_ext.dart';
import '../ast/general_visitor.dart';
import '../context/analyzed_file.dart';
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

const _uuid = Uuid();
final lintResultsProvider =
    FutureProvider.family<Set<LintResult>?, AnalyzedFileWithContext>(
        (ref, file) async {
  // final keepAlive = ref.keepAlive();
  Future<Set<LintResult>> v() async {
    final visitor = ref.watch(registryVisitorProvider(file));
    final visitors = ref.watch(scopedVisitorForFileProvider(file));
    final rules = ref.watch(scopedLintRulesForFileProvider(file));
    final visitorRules = ref.watch(scopedVisitorForFileProvider(file));
    final unit = await ref.watch(resolvedUnitForFileProvider(file).future);
    if (unit == null) return {};
    for (final visitor in visitors) {
      visitor.setUnit(unit);
    }
    unit.unit.accept(visitor);
    return visitor.results;
  }

  // final operation = CancelableOperation.fromFuture(v(), onCancel: () => null);

  final id = _uuid.v4();
  ref.onDispose(() {
    print('$id DISPOSED ${file.toString()}');
    // operation.isCompleted ? operation.cancel() : () {};
    // keepAlive.close();
  });

  // print('$id lintResultsProvider STARTED');

  // Future<Set<LintResult>> _function() async {
  // return visitor.results;
  // return operation.valueOrCancellation();
  return v();
  // });
  // }

  // final result =
  //     CancelableOperation.fromFuture(_function(), onCancel: () => null);
  // ref.onCancel(result.cancel);

  // return result.valueOrCancellation();
  // return _function();
  // return guardedResult.valueOrNull;
});

final lintResultsCompleterProvider = FutureProvider.autoDispose((ref) async {
  final elements = ref.container
      .getAllProviderElements()
      .where((base) => base.origin.from == lintResultsProvider)
      .map((e) => e.origin as FutureProvider<Set<LintResult>>);
  print('lintResultsCompleterProvider rebuilding...');
  // we want to await for all lints to be computed before proceeding with any
  // pro-active quick-fix computing
  await Future.wait(elements.map((e) async => ref.watch(e.future)));
});

final assistFiltersProvider = FutureProvider.family
    .autoDispose<Set<LintResult>, AnalyzedFileWithContext>((ref, file) async {
  final registry = ref.watch(nodeRegistryForFileProvider(file));
  final visitor = RegisteredLintVisitor(registry);

  await ref.watch(lintResultsCompleterProvider.future);
  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);
  //todo filter out assist results, not LintResult
  // returns [] if unit == null or if visitor doesnt find anything
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
  await ref.watch(lintResultsCompleterProvider.future);
  final lintResults = await ref.watch(lintResultsProvider(file).future);
  // lintResults.map((e) => e.)
  return [];
  // calculate edits
});
