// import 'package:riverpod/riverpod.dart';
// import 'package:sidecar/builder.dart';

// import '../../analyzed_file/analyzed_file.dart';

// class ErrorReporter {
//   const ErrorReporter(this.ref, this.file);

//   final AnalyzedFile file;
//   final Ref ref;

//   Future<List<DartAnalysisResult>> generateDartAnalysisResults(
//     ResolvedUnitResult unit,
//     LintRule rule,
//   ) async {
//     final detectedLints = await rule.computeDartAnalysisResults(unit);
//     return detectedLints;
//   }

//   Future<List<AnalysisResult>> generateAvailableDartFixes(
//     ResolvedUnitResult unit,
//     CodeEdit rule,
//     int offset,
//     int length,
//   ) async {
//     final detectedLints = await rule.computeDartAnalysisResults(unit);
//     return detectedLints;
//   }

//   // Future<List<PrioritizedSourceChange>> generateDartFixes(
//   //   ResolvedUnitResult unit,
//   //   CodeEdit rule,
//   //   int offset,
//   //   int length,
//   // ) async {
//   //   final results = ref.read(analysis(file)).valueOrNull ?? [];

//   //   final relevantResults =
//   //       results.where((result) => result.isWithinOffset(unit.path, offset));

//   //   final editResults = await Future.wait(relevantResults
//   //       .map((result) => rule.computeSourceChanges(unit.session, result)));

//   //   final flattenedResults = editResults.expand((element) => element).toList();

//   //   return flattenedResults.map((e) => e.toPrioritizedSourceChange()).toList();
//   // }
// }
