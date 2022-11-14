import '../../configurations/configurations.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';

bool _isPathIncludedForRule({
  required AnalyzedFile file,
  required BaseRule rule,
  required ProjectConfiguration projectConfiguration,
}) {
  // print(relativePath);
  // #1 check explicit LintRule/CodeEdit includes from project config
  final ruleConfig = projectConfiguration.getConfigurationForRule(rule);

  if (ruleConfig != null && ruleConfig.includes != null) {
    return ruleConfig.includesMatch(file.relativePath);
  }

  // #2 check default LintRule/CodeEdit includes from lint/edit definition
  if (rule.includes != null) {
    return rule.includes!.any((glob) => glob.matches(file.relativePath));
  }

  final rulePackageConfig =
      projectConfiguration.getPackageConfigurationForRule(rule);

  // check explicit LintPackage includes from project config
  if (rulePackageConfig != null && rulePackageConfig.includes != null) {
    return rulePackageConfig.includesMatch(file.relativePath);
  }

  // TODO: #4 check default LintPackage includes from LintPackage definition

  // #5 check project configuration
  return projectConfiguration.doesInclude(file.relativePath);
}
