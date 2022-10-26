import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

part 'analysis_source.freezed.dart';

@freezed
class AnalysisSource with _$AnalysisSource {
  const factory AnalysisSource({
    required SourceSpan span,
    required String path,
  }) = _AnalysisSource;
  const AnalysisSource._();
}
