import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../configurations/configurations.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../../services/services.dart';
import '../context/context.dart';
import 'analysis_contexts_provider.dart';
import 'rule_constructors_provider.dart';

part 'rules.g.dart';

@riverpod
List<LintRule> lintRulesForFile(
  LintRulesForFileRef ref,
  AnalyzedFile file,
) {
  return ref.watch(filteredRulesForFileProvider(file)
      .select((rules) => rules.whereType<LintRule>().toList()));
}

@riverpod
List<LintRule> lintRulesForRoot(
  LintRulesForRootRef ref,
  Context root,
) {
  return ref.watch(activatedRulesForRootProvider(root)
      .select((rules) => rules.whereType<LintRule>().toList()));
}

@riverpod
List<AssistRule> assistRulesForRoot(
  AssistRulesForRootRef ref,
  Context root,
) {
  return ref.watch(activatedRulesForRootProvider(root)
      .select((rules) => rules.whereType<AssistRule>().toList()));
}

@riverpod
List<AssistRule> assistRulesForFile(
  AssistRulesForFileRef ref,
  AnalyzedFile file,
) {
  return ref.watch(filteredRulesForFileProvider(file)
      .select((rules) => rules.whereType<AssistRule>().toList()));
}

@riverpod
List<BaseRule> activatedRulesForRoot(
  ActivatedRulesForRootRef ref,
  Context root,
) {
  final context = ref.watch(activeContextNotifierProvider)!;
  final constructors = ref.watch(ruleConstructorProvider);
  final ruleService = ref.watch(ruleInitializationServiceProvider);
  return ruleService.constructRules(context.sidecarOptions, constructors, root);
}

@riverpod
List<BaseRule> filteredRulesForFile(
  FilteredRulesForFileRef ref,
  AnalyzedFile file,
) {
  final allRules = ref.watch(activatedRulesForRootProvider(file.context));
  final context = ref.watch(activeContextNotifierProvider)!;
  return allRules
      .where((rule) => _isPathIncludedForRule(
          file: file, rule: rule, projectConfiguration: context.sidecarOptions))
      .toList();
}

bool _isPathIncludedForRule({
  required AnalyzedFile file,
  required BaseRule rule,
  required ProjectConfiguration projectConfiguration,
}) {
  // #1 check explicit LintRule/CodeEdit includes from project config
  final ruleConfig = projectConfiguration.getConfigurationForRule(rule);

  if (ruleConfig != null && ruleConfig.includes != null) {
    return ruleConfig.includes!.any((glob) => glob.matches(file.relativePath));
  }

  // #2 check default LintRule/CodeEdit includes from lint/edit definition
  if (rule.includes != null) {
    return rule.includes!.any((glob) => glob.matches(file.relativePath));
  }

  // TODO: #3 check explicit LintPackage includes from project config
  // TODO: #4 check default LintPackage includes from LintPackage definition

  // #5 check project configuration
  return projectConfiguration.includes(file.relativePath);
}
