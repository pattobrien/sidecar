import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import '../../services/project_configuration_service/project_configuration.dart';
import 'activated_rules_provider.dart';
import 'analyzed_file.dart';

/// Filter rules based on globs defined in project configuration
final filteredRulesProvider =
    Provider.family<List<SidecarBase>, AnalyzedFile>((ref, analyzedFile) {
  final contextRoot = analyzedFile.contextRoot;
  final allRules = ref.watch(activatedRulesProvider(contextRoot));
  final projectConfiguration =
      ref.watch(projectConfigurationProvider(contextRoot));

  if (projectConfiguration == null) return [];

  return allRules
      .where((rule) => _isPathIncludedForRule(
          file: analyzedFile,
          rule: rule,
          projectConfiguration: projectConfiguration))
      .toList();
});

bool _isPathIncludedForRule({
  required AnalyzedFile file,
  required SidecarBase rule,
  required ProjectConfiguration projectConfiguration,
}) {
  final relativePath = p.relative(file.path, from: file.contextRoot.root.path);

  // #1 check explicit LintRule/CodeEdit includes from project config
  final ruleConfig = projectConfiguration.getConfiguration(rule.id);

  if (ruleConfig != null && ruleConfig.includes != null) {
    return ruleConfig.includes!.any((glob) => glob.matches(relativePath));
  }

  // #2 check default LintRule/CodeEdit includes from lint/edit definition
  if (rule.includes != null) {
    return rule.includes!.any((glob) => glob.matches(relativePath));
  }

  // TODO: #3 check explicit LintPackage includes from project config
  // TODO: #4 check default LintPackage includes from LintPackage definition

  // #5 check project configuration
  return projectConfiguration.includes(relativePath);
}
