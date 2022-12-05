import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('lint configuration parse (enabled):', () {
    test('set to true', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': true,
        'includes': ['**/*.dart']
      });
      final value = yamlContent.parseEnabled();

      expect(value.data, true);
      expect(value.errors, <SidecarNewException>[]);
    });
    test('set to false', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': false,
        'includes': ['**/*.dart']
      });
      final value = yamlContent.parseEnabled();

      expect(value.data, false);
      expect(value.errors, <SidecarNewException>[]);
    });

    test('set to an invalid value', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': 123,
        'includes': ['**/*.dart']
      });
      final value = yamlContent.parseEnabled();

      expect(value.data, null);
      expect(value.errors.length, 1);
    });
  });
}
