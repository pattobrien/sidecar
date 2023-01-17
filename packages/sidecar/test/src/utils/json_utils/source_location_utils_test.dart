import 'dart:io';

import 'package:sidecar/src/utils/json_utils/source_location_utils.dart';
import 'package:source_span/source_span.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('sourceLocationToJson:', () {
    test('output json', () {
      final location = SourceLocation(10,
          sourceUrl: Directory.current.uri, line: 1, column: 10);
      final json = sourceLocationToJson(location);
      expect(json, <String, dynamic>{
        'offset': 10,
        'sourceUrl': Directory.current.uri.toFilePath(),
        'line': 1,
        'column': 10,
      });
    });
  });
  group('sourceLocationFromJson:', () {
    test('take json as input', () {
      final json = <String, dynamic>{
        'offset': 10,
        'sourceUrl': Directory.current.path,
        'line': 1,
        'column': 10,
      };
      final location = sourceLocationFromJson(json);
      expect(
        location,
        SourceLocation(
          10,
          sourceUrl: Uri.file(Directory.current.path),
          line: 1,
          column: 10,
        ),
      );
    });
  });
}
