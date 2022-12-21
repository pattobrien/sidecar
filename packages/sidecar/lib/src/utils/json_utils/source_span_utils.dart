import 'package:source_span/source_span.dart';

import 'source_location_utils.dart';

Map<String, dynamic> sourceSpanToJson(SourceSpan sourceSpan) {
  return <String, dynamic>{
    'start': sourceLocationToJson(sourceSpan.start),
    'end': sourceLocationToJson(sourceSpan.end),
    'text': sourceSpan.text,
    'sourceUrl': sourceSpan.sourceUrl?.toFilePath(),
  };
}

SourceSpan sourceSpanFromJson(Map<String, dynamic> json) {
  final textJson = json['text'] as String;
  final start = sourceLocationFromJson(json['start'] as Map<String, dynamic>);
  final end = sourceLocationFromJson(json['end'] as Map<String, dynamic>);
  return SourceSpan(start, end, textJson);
}
