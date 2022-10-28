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
    required SourceCursor source,
    required String path,
  }) = AnalysisSourceCursor;

  const AnalysisSource._();

  Uri get sourceUrl =>
      map(span: (span) => span.sourceUrl, cursor: (cursor) => cursor.sourceUrl);
}

class SourceCursor {
  const SourceCursor({
    required this.sourceUrl,
    required this.location,
  });

  final Uri sourceUrl;
  final SourceLocation location;
}
