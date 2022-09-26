import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

part 'analysis_errors.freezed.dart';

final detectedLintsProvider =
    StateProvider.family<Iterable<DetectedLint>, AnalyzedFile>(
  (ref, analyzedFile) => <DetectedLint>[],
);

@freezed
class AnalyzedFile with _$AnalyzedFile {
  const AnalyzedFile._();
  const factory AnalyzedFile(
    ContextRoot contextRoot,
    String path,
  ) = _AnalyzedFile;
}

extension AnalysisCollectionXX on AnalysisContextCollection {
  AnalysisContext contextFromAnalyzedFile(AnalyzedFile analyzedFile) =>
      contextFor(analyzedFile.path);
}
