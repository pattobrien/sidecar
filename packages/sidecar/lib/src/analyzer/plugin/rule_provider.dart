import 'package:riverpod/riverpod.dart';

import '../../rules/enabled_rule.dart';
import '../../rules/rules.dart';
import 'project_configuration_provider.dart';
import 'rule_constructors_provider.dart';

//
final _enabledRulesProvider = Provider<List<EnabledRule>>((ref) {
  // this will never rebuild
  final constructors = ref.watch(ruleConstructorProvider);

  // rebuilds any time the project configuration changes
  // TODO: can we make this more efficient?
  //TODO: if one detail in the project config changes, do we need to
  // re-initialize every single rule? or does riverpod not work like that?
  final projectConfiguration = ref.watch(projectConfigurationProvider);

  final enabledRules = constructors.map((constructor) {
    final rule = constructor();
    if (rule is LintRule) {
      final packageConfig =
          projectConfiguration.lintPackages?[rule.code.package];

      final ruleConfig = packageConfig?.lints?[rule.code.code];
      return EnabledRule(rule,
          configuration: ruleConfig, packageConfiguration: packageConfig);
    }
    if (rule is AssistRule) {
      final packageConfig =
          projectConfiguration.assistPackages?[rule.code.package];

      final ruleConfig = packageConfig?.assists?[rule.code.code];
      return EnabledRule(rule,
          configuration: ruleConfig, packageConfiguration: packageConfig);
    }
    return null;
  });
  // filter out null values by using whereType<EnabledRule>()
  return enabledRules.whereType<EnabledRule>().toList();
});

final activeRulesProvider = Provider((ref) {
  //  (indirectly) rebuilds any time project configuration changes
  final enabledRules = ref.watch(_enabledRulesProvider);

  final rulesWithNoConfig =
      enabledRules.where((rule) => rule.rule is! Configuration);

  final rulesWithConfig = enabledRules.where((enabledRule) {
    // TODO: rules need to throw errors and have them caught when
    // a) configuration is missing and it shouldnt be
    // b) configuration throws runtime error
    final baseRule = enabledRule.rule;

    if (baseRule is! Configuration) return false;
    // is the below efficient enough?
    final ruleConfig = ref.watch(projectConfigurationProvider
        .select((value) => value.getConfigurationForRule(baseRule)));
    baseRule.init(ruleConfiguration: ruleConfig?.configuration);
    return true;
  });

  return [...rulesWithNoConfig, ...rulesWithConfig];
});
