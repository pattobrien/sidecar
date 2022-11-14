import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../configurations/project/project.dart';
import '../protocol/protocol.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';

class RuleInitializationService {
  const RuleInitializationService();

  List<BaseRule> constructRules(
    ProjectConfiguration config,
    List<SidecarBaseConstructor> ruleConstructors,
    Context activeRoot,
  ) {
    logger.finer('lint packages init: ${config.lintPackages?.length ?? 0}');
    logger.finer('assist packages init: ${config.assistPackages?.length ?? 0}');
    return ruleConstructors
        .map((ruleConstructor) {
          final rule = ruleConstructor();
          final ruleConfig = config.getConfigurationForRule(rule);

          // rule was not included in yaml, or was explicitly disabled,
          // so it shouldnt be initialized
          if (ruleConfig == null || ruleConfig.enabled == false) return null;

          logger.finer('activating ${rule.code}');

          return rule;
        })
        .whereNotNull()
        .toList();
  }
}

final ruleInitializationServiceProvider = Provider(
  (_) => const RuleInitializationService(),
  name: 'ruleInitializationServiceProvider',
  dependencies: const [],
);
