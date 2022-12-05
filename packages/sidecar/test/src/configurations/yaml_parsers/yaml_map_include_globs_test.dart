import 'package:sidecar/src/configurations/configurations.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('lint configuration parse (includes):', () {
    test('valid globs', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': true,
        'includes': ['bin/**', 'lib/**'],
      });
      final value = yamlContent.parseGlobIncludes();

      expect(value.data?.length ?? 0, 2);
      expect(value.errors.isEmpty, true);
    });
    test('invalid type', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': true,
        'includes': 'bin/**',
      });
      final value = yamlContent.parseGlobIncludes();

      expect(value.data, null);
      expect(value.errors.isEmpty, false);
    });

    test('set one glob to an invalid value', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'includes': ['bin/**', 123],
      });
      final value = yamlContent.parseGlobIncludes();

      expect(value.data?.length ?? 0, 1);
      expect(value.errors.length, 1);
    });
  });
}
