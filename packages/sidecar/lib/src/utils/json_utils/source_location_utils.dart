import 'package:source_span/source_span.dart';

Map<String, dynamic> sourceLocationToJson(SourceLocation location) {
  return <String, dynamic>{
    'offset': location.offset,
    'line': location.line,
    'column': location.column,
    'sourceUrl': location.sourceUrl?.path,
  };
}

SourceLocation sourceLocationFromJson(Map<String, dynamic> json) {
  return SourceLocation(
    json['offset'] as int,
    line: json['line'] as int,
    column: json['column'] as int,
    sourceUrl: json['sourceUrl'] as String?,
  );
}
