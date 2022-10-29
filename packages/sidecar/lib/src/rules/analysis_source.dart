import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

part 'analysis_source.freezed.dart';

@freezed
class AnalysisSource with _$AnalysisSource {
  const factory AnalysisSource.span({
    required SourceSpan source,
    required String path,
  }) = AnalysisSourceSpan;

  const factory AnalysisSource.cursor({
    required SourceLocation source,
    required String path,
  }) = AnalysisSourceCursor;

  const AnalysisSource._();

  Uri get sourceUrl => map(
        span: (span) => span.source.sourceUrl!,
        cursor: (cursor) => cursor.source.sourceUrl!,
      );
}
