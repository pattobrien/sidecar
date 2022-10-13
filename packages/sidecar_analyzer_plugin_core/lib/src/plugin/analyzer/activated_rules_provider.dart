import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../../services/log_delegate/log_delegate_base.dart';
import '../../services/project_configuration_service/project_configuration.dart';
import 'activated_rules_service.dart';
import 'rule_constructors_provider.dart';

final activatedRulesProvider = Provider.family<List<SidecarBase>, ContextRoot>(
  (ref, root) {
    ref.listenSelf((_, next) => ref
        .read(logDelegateProvider)
        .sidecarMessage('ISOLATE: initializedRules = ${next.length}'));

    // final annotations =
    //      ref.watch(annotationsAggregateProvider(root).future);
    final projectConfiguration = ref.watch(projectConfigurationProvider(root));
    final ruleConstructors = ref.watch(ruleConstructorProvider);
    final activatedRulesService = ref.watch(activatedRulesServiceProvider);

    if (projectConfiguration == null) return [];

    return activatedRulesService.initializeRules(
      [], // annotations,
      projectConfiguration,
      ruleConstructors,
    );
  },
  dependencies: [
    // annotationsAggregateProvider,
    activatedRulesServiceProvider,
    projectConfigurationProvider,
    ruleConstructorProvider,
    logDelegateProvider,
  ],
);
