import 'package:sidecar/sidecar.dart';
import 'package:test/test.dart';

void main() {
  group('lint configuration parse (severity):', () {
    test('valid severity', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'severity': 'warning',
      });
      final value = yamlContent.parseSeverity();

      expect(value.item1, LintSeverity.warning);
      expect(value.item2.isEmpty, true);
    });
    test('invalid severity', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'severity': 'warninga',
      });
      final value = yamlContent.parseSeverity();

      expect(value.item1, null);
      expect(value.item2.length, 1);
    });

    test('invalid severity type', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'severity': false,
      });
      final value = yamlContent.parseSeverity();

      expect(value.item1, null);
      expect(value.item2.length, 1);
    });
  });
}
