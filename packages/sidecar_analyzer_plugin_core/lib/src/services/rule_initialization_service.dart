import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import 'log_delegate/log_delegate_base.dart';

class RuleInitializationService {
  const RuleInitializationService(this.ref);
  final Ref ref;

  void _log(String msg) => ref.read(logDelegateProvider).sidecarMessage(msg);

  List<SidecarBase> initializeRules(
    List<SidecarAnnotatedNode> annotatedNodes,
    ProjectConfiguration projectConfiguration,
    List<SidecarBaseConstructor> ruleConstructors,
  ) {
    _log(
        'initializing ${projectConfiguration.lintPackages?.length ?? 0} lint packages');
    _log(
        'initializing ${projectConfiguration.assistPackages?.length ?? 0} assist packages');
    return ruleConstructors
        .map<SidecarBase?>((ruleConstructor) {
          final rule = ruleConstructor();
          final ruleConfig = projectConfiguration.getConfigurationForRule(rule);

          // rule was not included in yaml, so it shouldnt be initialized
          if (ruleConfig == null) return null;

          _log('activating ${rule.code}');
          rule.initialize(
            ref: ref,
            configurationContent: ruleConfig.configuration,
            lintNameSpan: ruleConfig.lintNameSpan,
            annotatedNodes: annotatedNodes,
          );
          if (rule.errors?.isNotEmpty ?? false) {
            // errorComposer.addErrors(rule.errors!);
            return null;
          } else {
            return rule;
          }
        })
        .whereType<SidecarBase>()
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
