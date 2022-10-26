import 'package:riverpod/riverpod.dart';

import '../analyzer/context/active_context_root.dart';
import '../analyzer/results/results.dart';
import '../analyzer/server/log_delegate.dart';
import '../configurations/project/project.dart';
import '../rules/rules.dart';

class RuleInitializationService {
  const RuleInitializationService(this.ref);
  final Ref ref;

  void _log(String msg) =>
      ref.read(logDelegateProvider).sidecarVerboseMessage(msg);

  List<BaseRule> initializeRules(
    ProjectConfiguration projectConfiguration,
    List<SidecarBaseConstructor> ruleConstructors,
    ActiveContextRoot activeRoot,
  ) {
    _log(
        'initializing ${projectConfiguration.lintPackages?.length ?? 0} lint packages');
    _log(
        'initializing ${projectConfiguration.assistPackages?.length ?? 0} assist packages');
    return ruleConstructors
        .map<BaseRule?>((ruleConstructor) {
          final rule = ruleConstructor();
          final ruleConfig = projectConfiguration.getConfigurationForRule(rule);

          // rule was not included in yaml, so it shouldnt be initialized
          if (ruleConfig == null) return null;

          _log('activating ${rule.code}');

          rule.initialize(
              ref: ref, activeRoot: activeRoot, configuration: ruleConfig);
          // if (rule.errors?.isNotEmpty ?? false) {
          //   // errorComposer.addErrors(rule.errors!);
          //   return null;
          // } else {
          return rule;
          // }
        })
        .whereType<BaseRule>()
        .toList();
  }
}

final ruleInitializationServiceProvider = Provider(
  RuleInitializationService.new,
  name: 'ruleInitializationServiceProvider',
  dependencies: [
    logDelegateProvider,
  ],
);
