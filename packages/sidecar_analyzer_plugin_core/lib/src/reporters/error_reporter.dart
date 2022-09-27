import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/sidecar.dart';
import 'package:sidecar_analyzer_plugin_core/src/context_services/analysis_errors.dart';

class ErrorReporter {
  ErrorReporter(this.file, this.ref)
      : results = ref.watch(analysisResultsProvider(file).state).state;

  final AnalyzedFile file;
  final Ref ref;
  final Iterable<AnalysisResult> results;

  Future<List<AnalysisResult>> generateDartLints(
    ResolvedUnitResult unit,
    LintRule rule,
    LintConfiguration? lintConfiguration,
  ) async {
    final detectedLints = await rule.computeDartAnalysisResults(unit);
    return detectedLints;
  }

  Future<List<AnalysisResult>> generateAvailableDartFixes(
    ResolvedUnitResult unit,
    CodeEdit rule,
    int offset,
    int length,
  ) async {
    final detectedLints = await rule.computeDartAnalysisResults(unit);
    return detectedLints;
  }

  Future<List<PrioritizedSourceChange>> generateDartFixes(
    ResolvedUnitResult unit,
    CodeEdit rule,
    int offset,
    int length,
  ) async {
    final relevantResults =
        results.where((element) => element.isWithinOffset(unit.path, offset));
    final editResults = await Future.wait(
        relevantResults.map((e) async => await rule.computeSourceChanges(e)));
    final flattenedResults = editResults.expand((element) => element).toList();
    return flattenedResults.map((e) => e.toPrioritizedSourceChange()).toList();
  }
}
