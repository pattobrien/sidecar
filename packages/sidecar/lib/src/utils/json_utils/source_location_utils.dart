import 'package:source_span/source_span.dart';

Map<String, dynamic> sourceLocationToJson(SourceLocation location) {
  // assert(location.sourceUrl?.path.endsWith('/') ?? true,
  //     'SourceLocation url should not end with backwards slash');
  return <String, dynamic>{
    'offset': location.offset,
    'line': location.line,
    'column': location.column,
    'sourceUrl': location.sourceUrl?.toFilePath(),
  };
}

SourceLocation sourceLocationFromJson(Map<String, dynamic> json) {
  return SourceLocation(
    json['offset'] as int,
    line: json['line'] as int,
    column: json['column'] as int,
    sourceUrl: Uri.file(json['sourceUrl'] as String),
  );
}
