import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import 'log_delegate/log_delegate_base.dart';

class ActivatedRulesService {
  const ActivatedRulesService(this.ref);
  final Ref ref;

  LogDelegateBase get log => ref.read(logDelegateProvider);

  List<SidecarBase> initializeRules(
    List<SidecarAnnotatedNode> annotatedNodes,
    ProjectConfiguration projectConfiguration,
    List<SidecarBaseConstructor> ruleConstructors,
  ) {
    return ruleConstructors
        .map<SidecarBase?>((ruleConstructor) {
          final rule = ruleConstructor.call();
          final i =
              Id(type: rule.type, packageId: rule.packageName, id: rule.code);
          final ruleConfig = projectConfiguration.getConfiguration(i);

          // rule was not included in yaml, so it shouldnt be initialized
          if (ruleConfig == null) return null;

          log.sidecarVerboseMessage('activating ${i.id}');
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

final activatedRulesServiceProvider = Provider(ActivatedRulesService.new);
