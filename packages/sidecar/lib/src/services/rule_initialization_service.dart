import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../configurations/sidecar_spec/sidecar_spec_base.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';

class RuleInitializationService {
  const RuleInitializationService();

  List<BaseRule> constructRules(
    SidecarSpec config,
    List<SidecarBaseConstructor> ruleConstructors,
  ) {
    logger.finer('lint packages init: ${config.lints?.length ?? 0}');
    logger.finer('assist packages init: ${config.assists?.length ?? 0}');
    return ruleConstructors
        .map((ruleConstructor) {
          final rule = ruleConstructor();
          final ruleConfig = config.getConfigurationForCode(rule.code);

          // rule was not included in yaml, or was explicitly disabled,
          // so it shouldnt be initialized
          if (ruleConfig == null || ruleConfig.enabled == false) return null;

          // if (rule is Configuration) {
          //   //
          // }

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
