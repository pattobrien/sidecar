import 'package:sidecar/sidecar.dart';
import 'package:test/test.dart';

void main() {
  group('lint configuration parse (enabled):', () {
    test('set to true', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': true,
        'includes': ['**/*.dart']
      });
      final value = yamlContent.parseEnabled();

      expect(value.item1, true);
      expect(value.item2, <SidecarNewException>[]);
    });
    test('set to false', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': false,
        'includes': ['**/*.dart']
      });
      final value = yamlContent.parseEnabled();

      expect(value.item1, false);
      expect(value.item2, <SidecarNewException>[]);
    });

    test('set to an invalid value', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'enabled': 123,
        'includes': ['**/*.dart']
      });
      final value = yamlContent.parseEnabled();

      expect(value.item1, null);
      expect(value.item2.length, 1);
    });
  });
}
