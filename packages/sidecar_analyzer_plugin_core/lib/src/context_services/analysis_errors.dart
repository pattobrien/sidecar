import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;
// import 'package:riverpod/riverpod.dart';
// import 'package:sidecar/sidecar.dart';

part 'analysis_errors.freezed.dart';

// final analysisResultsProvider =
//     StateProvider.family<Iterable<AnalysisResult>, AnalyzedFile>(
//   (ref, analyzedFile) => <AnalysisResult>[],
// );

@freezed
class AnalyzedFile with _$AnalyzedFile {
  const AnalyzedFile._();
  const factory AnalyzedFile(
    ContextRoot contextRoot,
    String path,
  ) = _AnalyzedFile;

  bool get isDartFile => p.extension(path) == '.dart';
}

extension AnalysisCollectionXX on AnalysisContextCollection {
  AnalysisContext contextFromAnalyzedFile(AnalyzedFile analyzedFile) =>
      contextFor(analyzedFile.path);
}
