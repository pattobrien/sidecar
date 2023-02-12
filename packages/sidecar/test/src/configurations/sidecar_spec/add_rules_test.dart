import 'dart:math';

import 'package:sidecar/src/configurations/rule_package/rule_package_configuration.dart';
import 'package:sidecar/src/configurations/sidecar_spec/add_rules.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('add rules to sidecarspec', () {
    final sourceUri = Uri.file('test.yaml');
    const packageName = 'test_lints';
    final rulePackageMap = loadYaml('''
lints:
  - foo
  - bar
''', sourceUrl: sourceUri) as YamlMap;
    final ruleConfig = RulePackageConfiguration.fromYamlMap(rulePackageMap,
        packageName: packageName, uri: sourceUri);
    test('add new rule package', () async {
      const currentSidecarSpecContents = '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    bar:
''';
      final newSidecarSpecContents = addRules(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(
          newSidecarSpecContents,
          '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    bar:
  test_lints: 
    foo: true
    bar: true
'''
              .trim());
    });

    test('append new rules to package', () async {
      const currentSidecarSpecContents = '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    bar:
  test_lints:
    foo: true
''';
      final newSidecarSpecContents = addRules(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(
          newSidecarSpecContents,
          '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    bar:
  test_lints:
    foo: true
    bar: true
'''
              .trim());
    });
  });
}
