import 'package:source_span/source_span.dart';

Map<String, dynamic> sourceSpanToJson(SourceSpan sourceSpan) {
  return <String, dynamic>{
    'start': {
      'offset': sourceSpan.start.offset,
      'line': sourceSpan.start.line,
      'column': sourceSpan.start.column,
      'sourceUrl': sourceSpan.end.sourceUrl!.path,
    },
    'end': {
      'offset': sourceSpan.end.offset,
      'line': sourceSpan.end.line,
      'column': sourceSpan.end.column,
      'sourceUrl': sourceSpan.end.sourceUrl!.path,
    },
    'text': sourceSpan.text,
    'sourceUrl': sourceSpan.sourceUrl!.path,
  };
}

SourceSpan sourceSpanFromJson(Map<String, dynamic> json) {
  final startJson = json['start'] as Map<String, dynamic>;
  final endJson = json['end'] as Map<String, dynamic>;
  final textJson = json['text'] as String;
  // final sourceUrlJson = json['sourceUrl'] as Uri?;
  final start = SourceLocation(
    startJson['offset'] as int,
    sourceUrl: startJson['sourceUrl'] as String,
    line: startJson['line'] as int?,
    column: startJson['column'] as int?,
  );
  final end = SourceLocation(
    endJson['offset'] as int,
    sourceUrl: endJson['sourceUrl'] as String,
    line: endJson['line'] as int?,
    column: endJson['column'] as int?,
  );

  return SourceSpan(start, end, textJson);
}
