import 'package:freezed_annotation/freezed_annotation.dart';

import '../../analyzer/context/context.dart';
import '../../analyzer/results/results.dart';

part 'file_stats.freezed.dart';

@freezed
class FileStats with _$FileStats {
  const FileStats._();
  const factory FileStats.initialResolve({
    required AnalyzedFile file,
    required List<AnalysisResult> analysisResults,
    required Duration timeToResolveUnit,
    required Duration timeToComputeAnnotations,
    required Duration timeToLint,
    required Duration totalTime,
  }) = InitialResolve;

  String toOutput() {
    return '''
report for file: ${file.relativePath}
|    unit updated in:            ${timeToResolveUnit.inMicroseconds}us
|    annotations collected in:   ${timeToComputeAnnotations.inMicroseconds}us
|    lint errors collected in:   ${timeToLint.inMicroseconds}us
|    total elapsed time:         ${totalTime.inMicroseconds}us
|    number of errors found:     ${analysisResults.length}
''';
  }
}
