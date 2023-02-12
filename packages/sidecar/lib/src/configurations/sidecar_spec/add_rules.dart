import 'package:yaml/yaml.dart';

import '../../utils/yaml_writer.dart';
import '../rule_package/rule_package_configuration.dart';
import '../rule_package/rule_yaml_nodes.dart';

String addRules(
  String originalContent,
  Uri sourceUri,
  List<RulePackageConfiguration> configs,
) {
  var currentContent = originalContent;
  var doc = loadYamlDocument(originalContent, sourceUrl: sourceUri);
  dynamic topLevel = doc.contents.value;
  if (topLevel is! YamlMap) throw UnimplementedError();

  for (final packageConfig in configs) {
    if (packageConfig.lints?.isEmpty ?? true) continue;
    final lints = topLevel.value['lints'] as YamlNode?;
    if (lints is! YamlMap) continue;
    currentContent = generateNewContent(
        currentContent, lints, packageConfig.packageName, packageConfig.lints);
    doc = loadYamlDocument(currentContent, sourceUrl: sourceUri);
    topLevel = doc.contents.value;
  }

  for (final packageConfig in configs) {
    if (packageConfig.assists?.isEmpty ?? true) continue;
    final assists = topLevel.value['assists'] as YamlNode?;
    if (assists is! YamlMap) continue;
    currentContent = generateNewContent(currentContent, assists,
        packageConfig.packageName, packageConfig.assists);
    doc = loadYamlDocument(currentContent, sourceUrl: sourceUri);
    topLevel = doc.contents.value;
  }
  return currentContent;
}

String generateRuleContent(Iterable<SidecarBaseNode> missingRules) {
  return const YamlWriter().write(indent: 2, {
    for (final rule in missingRules) rule.name: true,
  });
}

String generateNewContent(
  String originalContent,
  YamlMap packages,
  String packageName,
  List<SidecarBaseNode>? rules,
) {
  final packageOptions = packages.nodes[packageName];
  if (packageOptions == null) {
    // insert the package and all nodes at the end of the spec
    final offset = packages.span.end.offset;
    final lintNames = rules ?? [];
    final packageOptionsContent = const YamlWriter().write(indent: 1, {
      packageName: {
        for (final rule in lintNames) rule.name: true,
      }
    });

    return originalContent.substring(0, offset) +
        packageOptionsContent +
        originalContent.substring(offset);
  } else {
    // check if rules exist and if not, append them to the end
    final offset = packageOptions.span.end.offset;
    final dynamic ruleOptions = packageOptions.value;
    final ruleConfigs = rules ?? [];
    if (ruleOptions is YamlMap) {
      final missingRules = ruleConfigs.where((ruleConfig) {
        final name = ruleConfig.name;
        return ruleOptions.nodes[name] == null;
      });
      final missingRuleContent = generateRuleContent(missingRules);
      return originalContent.substring(0, offset) +
          missingRuleContent +
          originalContent.substring(offset);
    } else {
      final missingRuleContent = generateRuleContent(ruleConfigs);
      return originalContent.substring(0, offset) +
          missingRuleContent +
          originalContent.substring(offset);
    }
  }
}
