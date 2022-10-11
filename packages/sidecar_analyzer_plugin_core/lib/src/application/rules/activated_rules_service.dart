import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import '../../analysis_context/file_annotations_providers.dart';
import '../../services/log_delegate/log_delegate_base.dart';
import '../../services/project_configuration_service/providers.dart';
import '../../services/rule_constructor_provider.dart';

final activatedRulesProvider =
    FutureProvider.family<List<SidecarBase>, ContextRoot>(
  (ref, root) async {
    final annotations =
        await ref.watch(annotationsAggregateProvider(root).future);
    final projectConfiguration =
        await ref.watch(projectConfigurationProvider(root).future);
    final ruleDefinitions = ref.watch(ruleConstructorProvider);
    final activatedRulesNotifier = ActivatedRulesService(ref, root);
    return activatedRulesNotifier.initializeRules(
        annotations, projectConfiguration!, ruleDefinitions);
  },
  dependencies: [
    annotationsAggregateProvider,
    projectConfigurationProvider,
    ruleConstructorProvider,
    logDelegateProvider,
  ],
);

class ActivatedRulesService {
  ActivatedRulesService(this.ref, this.root);

  final ContextRoot root;
  final Ref ref;

  LogDelegateBase get log => ref.read(logDelegateProvider);

  List<SidecarBase> initializeRules(
    List<SidecarAnnotatedNode> annotatedNodes,
    ProjectConfiguration projectConfiguration,
    List<SidecarBaseConstructor> ruleDefinitions,
  ) {
    return ruleDefinitions
        .map<SidecarBase?>((ruleDefinition) {
          final rule = ruleDefinition();
          final i =
              Id(type: rule.type, packageId: rule.packageName, id: rule.code);
          final ruleConfig = projectConfiguration.getConfiguration(i);
          log.sidecarVerboseMessage('activating ${i.id}');
          rule.initialize(
            ref: ref,
            configurationContent: ruleConfig?.configuration,
            // lintNameSpan: ruleConfig!.lintNameSpan,
            lintNameSpan: SourceSpan(SourceLocation(0), SourceLocation(0), ''),
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
