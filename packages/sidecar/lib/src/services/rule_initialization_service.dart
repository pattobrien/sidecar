import 'package:riverpod/riverpod.dart';

import '../configurations/project/project.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';

class RuleInitializationService {
  const RuleInitializationService(this.ref);
  final Ref ref;

  List<BaseRule> constructRules(
    ProjectConfiguration projectConfiguration,
    List<SidecarBaseConstructor> ruleConstructors,
    Context activeRoot,
  ) {
    logger.finer(
        'initializing ${projectConfiguration.lintPackages?.length ?? 0} lint packages');
    logger.finer(
        'initializing ${projectConfiguration.assistPackages?.length ?? 0} assist packages');
    return ruleConstructors
        .map<BaseRule?>((ruleConstructor) {
          final rule = ruleConstructor();
          final ruleConfig = projectConfiguration.getConfigurationForRule(rule);

          // rule was not included in yaml, so it shouldnt be initialized
          if (ruleConfig == null) return null;
          // rule is marked as disabled
          if (ruleConfig.enabled == false) return null;

          logger.finer('activating ${rule.code}');

          return rule;
        })
        .whereType<BaseRule>()
        .toList();
  }
}

final ruleInitializationServiceProvider = Provider(
  RuleInitializationService.new,
  name: 'ruleInitializationServiceProvider',
  dependencies: const [],
);
