import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../../services/log_delegate/log_delegate_base.dart';
import '../../services/project_configuration_service/providers.dart';
import '../../services/rule_constructor_provider.dart';
import '../annotations/file_annotations_notifier.dart';
import 'activated_rules_state.dart';

final activatedRulesNotifierProvider = StateNotifierProvider.family<
    ActivatedRulesNotifier, ActivatedRulesState, ContextRoot>((ref, root) {
  return ActivatedRulesNotifier(ref, root);
});

class ActivatedRulesNotifier extends StateNotifier<ActivatedRulesState> {
  ActivatedRulesNotifier(this.ref, this.root)
      : super(const ActivatedRulesState());

  final ContextRoot root;
  final Ref ref;

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  void initializeRules() {
    state = const ActivatedRulesState();
    final annotatedNodes = ref.read(annotationsAggregateProvider(root));

    final projectConfig = ref.read(projectConfigurationProvider(root));

    if (projectConfig == null) return;

    final ruleDefinitions = ref.read(ruleConstructorProvider);

    for (final ruleDefinition in ruleDefinitions.entries) {
      final ruleId = ruleDefinition.key;
      final ruleConfig = projectConfig.getConfiguration(ruleId);
      final rule = ruleDefinition.value();
      final ruleCode = rule.code;
      delegate.sidecarMessage('activating $ruleCode');
      rule.initialize(
        ref: ref,
        configurationContent: ruleConfig?.configuration,
        lintNameSpan: ruleConfig!.lintNameSpan,
        annotatedNodes: annotatedNodes,
      );
      if (rule.errors?.isNotEmpty ?? false) {
        // errorComposer.addErrors(rule.errors!);
      } else {
        state = state.copyWith(
          rules: List.from(<SidecarBase>[...state.rules, rule]),
        );
      }
    }
  }
}
