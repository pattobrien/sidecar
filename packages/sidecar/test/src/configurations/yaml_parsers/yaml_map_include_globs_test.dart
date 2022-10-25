import 'package:sidecar/sidecar.dart';
import 'package:test/test.dart';

void main() {
  group('lint configuration parse (includes):', () {
    test('valid globs', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': true,
        'includes': ['bin/**', 'lib/**'],
      });
      final value = yamlContent.parseGlobIncludes();

      expect(value.item1?.length ?? 0, 2);
      expect(value.item2.isEmpty, true);
    });
    test('invalid type', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': true,
        'includes': 'bin/**',
      });
      final value = yamlContent.parseGlobIncludes();

      expect(value.item1, null);
      expect(value.item2.isEmpty, false);
    });

    test('set one glob to an invalid value', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'includes': ['bin/**', 123],
      });
      final value = yamlContent.parseGlobIncludes();

      expect(value.item1?.length ?? 0, 1);
      expect(value.item2.length, 1);
    });
  });
}
