// import 'package:analyzer/file_system/physical_file_system.dart';
// import 'package:sidecar/sidecar.dart';
// import 'package:sidecar/src/configurations/rule_package/rule_package_configuration.dart';
// import 'package:sidecar/src/services/services.dart';
// import 'package:test/scaffolding.dart';

// const yamlContent = '''
// sidecar:
//   lints:
//     - some_lint_rule
//     - some_lint_rule_2
// ''';

// void main() {
//   final resourceProvider = PhysicalResourceProvider.INSTANCE;
//   final service = EntrypointBuilderService(resourceProvider: resourceProvider);
//   group('entrypoint builder service:', () {
//     test('description', () {
//       final yamlMap = loadYaml(yamlContent) as YamlMap;
//       final ruleConfig1 = RulePackageConfiguration.fromYamlMap(yamlMap,
//           uri: uri, packageName: packageName);
//       final generatedContent = service.generateEntrypointContent([ruleConfig1]);
//     });
//   });
// }

void main() {}
