import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../configurations/configurations.dart';
import '../../rules/rules.dart';
import '../../services/services.dart';
import '../context/context.dart';
import 'active_contexts_provider.dart';
import 'rule_constructors_provider.dart';

final lintRulesForFileProvider = Provider.family<List<LintRule>, AnalyzedFile>(
  (ref, analyzedFile) {
    return ref.watch(_filteredRulesProvider(analyzedFile).select(
      (rules) => rules.whereType<LintRule>().toList(),
    ));
  },
  name: 'lintRulesForFileProvider',
  dependencies: [
    _filteredRulesProvider,
  ],
);

final assistRulesForFileProvider =
    Provider.family<List<AssistRule>, AnalyzedFile>(
  (ref, analyzedFile) {
    return ref.watch(_filteredRulesProvider(analyzedFile)
        .select((value) => value.whereType<AssistRule>().toList()));
  },
  name: 'assistRulesForFileProvider',
  dependencies: [
    _filteredRulesProvider,
  ],
);

final activatedRulesProvider =
    Provider.family<List<BaseRule>, ActiveContextRoot>(
  (ref, activeRoot) {
    final context = ref.watch(activeContextForRootProvider(activeRoot));
    final ruleConstructors = ref.watch(ruleConstructorProvider);
    final ruleService = ref.watch(ruleInitializationServiceProvider);

    return ruleService.initializeRules(
      context.sidecarOptions,
      ruleConstructors,
      activeRoot,
    );
  },
  name: '_activatedRulesProvider',
  dependencies: [
    activeContextForRootProvider,
    ruleInitializationServiceProvider,
    ruleConstructorProvider,
  ],
);

/// Filter rules based on globs defined in project configuration
final _filteredRulesProvider = Provider.family<List<BaseRule>, AnalyzedFile>(
  (ref, analyzedFile) {
    final allRules = ref.watch(activatedRulesProvider(analyzedFile.root));
    final context = ref.watch(activeContextsProvider).contextFor(analyzedFile)!;

    return allRules
        .where((rule) => _isPathIncludedForRule(
            file: analyzedFile,
            rule: rule,
            projectConfiguration: context.sidecarOptions))
        .toList();
  },
  name: '_filteredRulesProvider',
  dependencies: [
    activeContextsProvider,
    activatedRulesProvider,
  ],
);

bool _isPathIncludedForRule({
  required AnalyzedFile file,
  required BaseRule rule,
  required ProjectConfiguration projectConfiguration,
}) {
  final relativePath = p.relative(file.path, from: file.root.root.path);

  // #1 check explicit LintRule/CodeEdit includes from project config
  final ruleConfig = projectConfiguration.getConfigurationForRule(rule);

  if (ruleConfig != null && ruleConfig.includes != null) {
    return ruleConfig.includes!.any((glob) => glob.matches(relativePath));
  }

  // #2 check default LintRule/CodeEdit includes from lint/edit definition
  if (rule.includes != null) {
    return rule.includes!.any((glob) => glob.matches(relativePath));
  }

  // TODO: #3 check explicit LintPackage includes from project config
  // TODO: #4 check default LintPackage includes from LintPackage definition

  // #5 check project configuration
  return projectConfiguration.includes(relativePath);
}
