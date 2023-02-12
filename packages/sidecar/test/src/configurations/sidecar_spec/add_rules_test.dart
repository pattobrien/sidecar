import 'package:sidecar/src/configurations/rule_package/rule_package_configuration.dart';
import 'package:sidecar/src/configurations/sidecar_spec/add_rules.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('add lint rules to sidecarspec', () {
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
    rules:
      bar:
''';
      final newSidecarSpecContents = addRulesToSidecarSpecContents(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(newSidecarSpecContents, '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    rules:
      bar:
  test_lints: 
    rules: 
      foo: true
      bar: true
''');
    });

    test('append new rules to package', () async {
      const currentSidecarSpecContents = '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
''';
      final newSidecarSpecContents = addRulesToSidecarSpecContents(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(newSidecarSpecContents, '''
includes:
  - "lib/**.dart"

lints:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
      bar: true
''');
    });
  });

  group('add assist rules to sidecarspec', () {
    final sourceUri = Uri.file('test.yaml');
    const packageName = 'test_lints';
    final rulePackageMap = loadYaml('''
assists:
  - foo
  - bar
''', sourceUrl: sourceUri) as YamlMap;
    final ruleConfig = RulePackageConfiguration.fromYamlMap(rulePackageMap,
        packageName: packageName, uri: sourceUri);
    test('add new assist rule package', () async {
      const currentSidecarSpecContents = '''
includes:
  - "lib/**.dart"

assists:
  bar_lints:
    rules:
      baz:
''';
      final newSidecarSpecContents = addRulesToSidecarSpecContents(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(newSidecarSpecContents, '''
includes:
  - "lib/**.dart"

assists:
  bar_lints:
    rules:
      baz:
  test_lints: 
    rules: 
      foo: true
      bar: true
''');
    });

    test('append new assist rules to package', () async {
      const currentSidecarSpecContents = '''
includes:
  - "lib/**.dart"

assists:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
''';
      final newSidecarSpecContents = addRulesToSidecarSpecContents(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(newSidecarSpecContents, '''
includes:
  - "lib/**.dart"

assists:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
      bar: true
''');
    });
  });
  group('append multiple rules and rule packages', () {
    final sourceUri = Uri.file('test.yaml');
    const packageName = 'test_lints';
    final rulePackageMap = loadYaml('''
assists:
  - foo
  - bar
lints:
  - baz
''', sourceUrl: sourceUri) as YamlMap;

    final rulePackage2Map = loadYaml('''
assists:
  - foo
  - bar
lints:
  - baz
''', sourceUrl: sourceUri) as YamlMap;
    final ruleConfig = RulePackageConfiguration.fromYamlMap(rulePackageMap,
        packageName: packageName, uri: sourceUri);

    final ruleConfig2 = RulePackageConfiguration.fromYamlMap(rulePackage2Map,
        packageName: 'second_lints', uri: sourceUri);
    test('add new lint and assist rule package', () async {
      const currentSidecarSpecContents = '''
includes:
  - "lib/**.dart"
lints:
  bar_lints:
    rules:
      baz:
assists:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
''';
      final newSidecarSpecContents = addRulesToSidecarSpecContents(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(newSidecarSpecContents, '''
includes:
  - "lib/**.dart"
lints:
  bar_lints:
    rules:
      baz:
  test_lints: 
    rules: 
      baz: true
assists:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
      bar: true
''');
    });

    test('add multiple packages', () async {
      const currentSidecarSpecContents = '''
includes:
  - "lib/**.dart"
lints:
  bar_lints:
    rules:
      baz:
assists:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
''';
      final newSidecarSpecContents = addRulesToSidecarSpecContents(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig, ruleConfig2],
      );
      expect(newSidecarSpecContents, '''
includes:
  - "lib/**.dart"
lints:
  bar_lints:
    rules:
      baz:
  test_lints: 
    rules: 
      baz: true
  second_lints: 
    rules: 
      baz: true
assists:
  bar_lints:
    rules:
      bar:
  test_lints:
    rules:
      foo: true
      bar: true
  second_lints: 
    rules: 
      foo: true
      bar: true
''');
    });

    test('add new lint and assist rule package to empty SidecarSpec', () async {
      const currentSidecarSpecContents = '';
      final newSidecarSpecContents = addRulesToSidecarSpecContents(
        currentSidecarSpecContents,
        sourceUri,
        [ruleConfig],
      );
      expect(newSidecarSpecContents, '''
includes:
  - "lib/**.dart"

lints:
  test_lints: 
    rules: 
      baz: true
 

assists:
  test_lints: 
    rules: 
      foo: true
      bar: true
 
''');
    });
  });
}
