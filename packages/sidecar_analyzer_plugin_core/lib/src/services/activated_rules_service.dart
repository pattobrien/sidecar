import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import 'log_delegate/log_delegate_base.dart';

class ActivatedRulesService {
  const ActivatedRulesService(this.ref);
  final Ref ref;

  void _log(String msg) => ref.read(logDelegateProvider).sidecarMessage(msg);

  List<SidecarBase> initializeRules(
    List<SidecarAnnotatedNode> annotatedNodes,
    ProjectConfiguration projectConfiguration,
    List<SidecarBaseConstructor> ruleConstructors,
  ) {
    _log(
        'package configuration = ${projectConfiguration.lintPackages?.entries.first ?? 0}');
    return ruleConstructors
        .map<SidecarBase?>((ruleConstructor) {
          final rule = ruleConstructor();
          final ruleConfig = projectConfiguration.getConfigurationForRule(rule);
          // _log('${rule.id} initialized = ${ruleConfig != null}');
          // rule was not included in yaml, so it shouldnt be initialized
          if (ruleConfig == null) return null;

          _log('activating ${rule.id}');
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

final activatedRulesServiceProvider = Provider(
  ActivatedRulesService.new,
  name: 'activatedRulesServiceProvider',
  dependencies: [
    logDelegateProvider,
  ],
);
