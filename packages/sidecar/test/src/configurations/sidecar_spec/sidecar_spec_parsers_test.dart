import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:test/test.dart';

void main() {
  group('misconfigured map', () {
    test('blank contents', () {
      const blankContents = '';
      final result = parseSidecarSpec(blankContents);
      expect(result.errors, <SidecarNewException>[]);
    });

    test('bad map', () {
      // tuple should return an empty SidecarSpec() as well as an exception
      const blankContents = 'a';
      final result = parseSidecarSpec(blankContents);
      expect(result.errors.length, 1);
    });
  });

  group('well formatted', () {
    test('lints with no values', () {
      // tuple should return an empty SidecarSpec() as well as an exception
      const contents = '''
lints:
''';
      final result = parseSidecarSpec(contents);
      expect(result.errors.length, 0);
    });

    test('assists with no values', () {
      // tuple should return an empty SidecarSpec() as well as an exception
      const contents = '''
assists:
''';
      final result = parseSidecarSpec(contents);
      expect(result.errors.length, 0);
    });

    test('lint package with no values', () {
      // tuple should return an empty SidecarSpec() as well as an exception
      const contents = '''
lints:
  design_system_lints:
''';
      final result = parseSidecarSpec(contents);
      expect(result.errors.length, 0);
    });

    test('assist package with no values', () {
      // tuple should return an empty SidecarSpec() as well as an exception
      const contents = '''
assists:
  design_system_lints:
''';
      final result = parseSidecarSpec(contents);
      expect(result.errors.length, 0);
    });

    test('lint package rules but no values', () {
      // tuple should return an empty SidecarSpec() as well as an exception
      const contents = '''
lints:
  design_system_lints:
    rules:
''';
      final result = parseSidecarSpec(contents);
      expect(result.errors.length, 0);
    });

    test('assist package rules but no values', () {
      // tuple should return an empty SidecarSpec() as well as an exception
      const contents = '''
assists:
  design_system_lints:
    rules:
''';
      final result = parseSidecarSpec(contents);
      expect(result.errors.length, 0);
    });
  });

  group('unknown values', () {});
}
