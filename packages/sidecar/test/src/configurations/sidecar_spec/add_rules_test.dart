import 'dart:math';

import 'package:sidecar/src/configurations/rule_package/rule_package_configuration.dart';
import 'package:sidecar/src/configurations/sidecar_spec/add_rules.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('add rules to sidecarspec', () {
    test('add rule', () async {
      final sourceUri = Uri.file('test.yaml');
      const packageName = 'test_lints';
      final rulePackageMap = loadYaml('''
lints:
  - foo
  - bar
''', sourceUrl: sourceUri) as YamlMap;
      final ruleConfig = RulePackageConfiguration.fromYamlMap(rulePackageMap,
          packageName: packageName, uri: sourceUri);
      final newContents = addRules(
        '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    bar:
''',
        sourceUri,
        [ruleConfig],
      );
      expect(
          newContents,
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
