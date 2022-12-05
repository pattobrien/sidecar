import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/configurations/configurations.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('lint configuration parse (severity):', () {
    test('valid severity', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'severity': 'warning',
      });
      final value = yamlContent.parseSeverity();

      expect(value.data, LintSeverity.warning);
      expect(value.errors.isEmpty, true);
    });
    test('invalid severity', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'severity': 'warninga',
      });
      final value = yamlContent.parseSeverity();

      expect(value.data, null);
      expect(value.errors.length, 1);
    });

    test('invalid severity type', () {
      final yamlContent = YamlMap.wrap(<dynamic, dynamic>{
        'severity': false,
      });
      final value = yamlContent.parseSeverity();

      expect(value.data, null);
      expect(value.errors.length, 1);
    });
  });
}
