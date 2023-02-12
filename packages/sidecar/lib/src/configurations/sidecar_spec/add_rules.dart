import 'package:yaml/yaml.dart';

import '../../../sidecar.dart';
import '../configurations.dart';
import '../rule_package/rule_package_configuration.dart';

String addRules(
  String originalContent,
  Uri sourceUri,
  List<RulePackageConfiguration> configs,
) {
  final doc = loadYamlDocument(originalContent, sourceUrl: sourceUri);
  final spec = parseSidecarSpec(originalContent, fileUri: sourceUri);
  final dynamic topLevel = doc.contents.value;
  if (topLevel is! YamlMap) throw UnimplementedError();

  for (final packageConfig in configs) {
    if (packageConfig.lints?.isEmpty ?? true) continue;
    final lints = topLevel.value['lints'] as YamlNode?;
    if (lints is! YamlMap) continue;
    final packageOptions = lints.nodes[packageConfig.packageName];
    if (packageOptions == null) {
      // insert the package and all nodes at the end of the spec
      final offset = lints.span.end.offset;
      final lintNames = packageConfig.lints ?? [];
      final packageOptionsContent = const YamlWriter().write(indent: 1, {
        packageConfig.packageName: {
          for (final rule in lintNames) rule.name: true,
        }
      });

      return originalContent.substring(0, offset) +
          packageOptionsContent +
          originalContent.substring(offset);
    } else {
      // check if rules exist and if not, append them to the end
      final offset = packageOptions.span.end.offset;
      final dynamic rules = packageOptions.value;
      if (rules is YamlMap) {
        final ruleConfigs = packageConfig.lints ?? [];
        final missingRules = ruleConfigs.where((ruleConfig) {
          final name = ruleConfig.name;
          return rules.nodes[name] == null;
        });
        final packageOptionsContent = const YamlWriter().write(indent: 2, {
          for (final rule in missingRules) rule.name: true,
        });

        return originalContent.substring(0, offset) +
            packageOptionsContent +
            originalContent.substring(offset);
      }
    }
  }

  for (final packageConfig in configs) {
    if (packageConfig.assists?.isEmpty ?? true) continue;
  }
  return originalContent;
}
