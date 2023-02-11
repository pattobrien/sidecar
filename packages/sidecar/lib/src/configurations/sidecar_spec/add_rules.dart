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

    if (lints.nodes[packageConfig.packageName] == null) {
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
    }
  }

  for (final packageConfig in configs) {
    if (packageConfig.assists?.isEmpty ?? true) continue;
  }
  return originalContent;
}
