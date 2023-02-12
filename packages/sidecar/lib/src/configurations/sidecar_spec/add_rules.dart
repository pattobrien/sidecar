import 'package:yaml/yaml.dart';

import '../../utils/yaml_writer.dart';
import '../rule_package/rule_package_configuration.dart';
import '../rule_package/rule_yaml_nodes.dart';

String addRulesToSidecarSpecContents(
  String originalContent,
  Uri sourceUri,
  List<RulePackageConfiguration> configs,
) {
  currentContent = originalContent;
  topLevel = recalcDoc(currentContent, sourceUri);

  for (final packageConfig in configs) {
    if (packageConfig.lints?.isEmpty ?? true) continue;
    final lints = topLevel.nodes['lints'];
    currentContent = generateNewContent(
        currentContent, lints, packageConfig.packageName, packageConfig.lints);
    topLevel = recalcDoc(currentContent, sourceUri);
  }

  for (final packageConfig in configs) {
    if (packageConfig.assists?.isEmpty ?? true) continue;
    final assists = topLevel.nodes['assists'];
    currentContent = generateNewContent(currentContent, assists,
        packageConfig.packageName, packageConfig.assists);
    topLevel = recalcDoc(currentContent, sourceUri);
  }
  return currentContent;
}

late String currentContent;
late YamlMap topLevel;

YamlMap recalcDoc(
  String content,
  Uri source,
) {
  final doc = loadYamlDocument(content, sourceUrl: source);
  // if ()
  final dynamic yamlContents = doc.contents.value;
  if (yamlContents is YamlMap) {
    return yamlContents;
  } else {
    const defaultContent = '''
includes:
  - "lib/**.dart"

lints: 

assists: 
''';
    currentContent = defaultContent;
    final doc = loadYamlDocument(defaultContent, sourceUrl: source);
    return doc.contents.value as YamlMap;
  }
}

String generateRuleContent(Iterable<SidecarBaseNode> missingRules) {
  return const YamlWriter().write(indent: 3, {
    for (final rule in missingRules) rule.name: true,
  });
}

String generateNewContent(
  String originalContent,
  YamlNode? packages,
  String packageName,
  List<SidecarBaseNode>? rules,
) {
  var content = originalContent;
  final packageOptions =
      packages is YamlMap ? packages.nodes[packageName] : null;
  if (packageOptions == null) {
    // insert the package and all nodes at the end of the spec
    var offset = packages?.span.end.offset ?? originalContent.length;
    if (packages is YamlScalar) {
      content = appendToOffset(originalContent, '\n', offset + 1);
      offset = offset + 2;
    }
    final lintNames = rules ?? [];
    final packageOptionsContent = const YamlWriter().write(indent: 1, {
      packageName: {
        'rules': {
          for (final rule in lintNames) rule.name: true,
        }
      }
    });
    return appendToOffset(content, packageOptionsContent, offset);
  } else {
    // check if rules exist and if not, append them to the end
    final offset = packageOptions.span.end.offset;
    final dynamic ruleOptions = packageOptions.value;
    final ruleConfigs = rules ?? [];
    if (ruleOptions is YamlMap) {
      final rulesMap = ruleOptions.nodes['rules'];
      if (rulesMap is! YamlMap) {
        throw UnimplementedError();
      }
      final missingRules = ruleConfigs.where((ruleConfig) {
        return rulesMap.nodes[ruleConfig.name] == null;
      });
      final missingRuleContent = generateRuleContent(missingRules);
      return appendToOffset(content, missingRuleContent, offset);
    } else {
      final missingRuleContent = generateRuleContent(ruleConfigs);
      return appendToOffset(content, missingRuleContent, offset);
    }
  }
}

String appendToOffset(String originalContent, String newContent, int offset) {
  return originalContent.substring(0, offset) +
      newContent +
      originalContent.substring(offset);
}
