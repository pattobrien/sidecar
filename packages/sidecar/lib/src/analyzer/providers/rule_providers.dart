import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../../rules/base_rule.dart';
import '../../services/rule_initialization_service.dart';
import '../ast/ast.dart';
import '../sidecar_analyzer.dart';
import 'sidecar_spec_providers.dart';

/// Provides list of rules enabled for the context
final ruleConstructorProvider = Provider<List<SidecarBaseConstructor>>(
  (ref) => throw UnimplementedError(),
  name: 'ruleConstructorProvider',
  dependencies: const [],
);

final _scopedRulesForActiveProjectProvider = Provider<Set<BaseRule>>((ref) {
  final ruleService = ref.watch(ruleInitializationServiceProvider);
  final config = ref.watch(projectSidecarSpecProvider);
  final constructors = ref.watch(ruleConstructorProvider);
  return ruleService.getRulesForActiveProject(config, constructors);
});

final _scopedRulesForFileProvider =
    Provider.family<Set<BaseRule>, AnalyzedFile>((ref, file) {
  final ruleService = ref.watch(ruleInitializationServiceProvider);
  final sidecarSpec = ref.watch(projectSidecarSpecProvider);
  final constructors = ref.watch(ruleConstructorProvider);
  final activeProjectRules = ref.watch(_scopedRulesForActiveProjectProvider);
  final rulesForFile = ruleService
      .constructRulesForFile(file, sidecarSpec, constructors)
      .intersection(activeProjectRules);

  logger.fine('_scopedRulesForFileProvider ${rulesForFile.map((e) => e.code)}');
  return rulesForFile;
});

final scopedLintRulesForFileProvider =
    Provider.family<Set<Lint>, AnalyzedFile>((ref, file) {
  final lints = ref.watch(_scopedRulesForFileProvider(file)
      .select((value) => value.whereType<Lint>().toSet()));

  for (final lint in lints) {
    //TODO: restrict updates to changes with rule/package config changes
    final sidecarSpec = ref.watch(projectSidecarSpecProvider);
    lint.setConfig(sidecarSpec: sidecarSpec);
  }
  return lints;
});

final scopedAssistRulesForFileProvider =
    Provider.family<Set<QuickAssist>, AnalyzedFile>((ref, file) {
  final assists = ref.watch(_scopedRulesForFileProvider(file)
      .select((value) => value.whereType<QuickAssist>().toSet()));

  for (final assist in assists) {
    //TODO: restrict updates to changes with rule/package config changes
    final sidecarSpec = ref.watch(projectSidecarSpecProvider);
    assist.setConfig(sidecarSpec: sidecarSpec);
  }
  return assists;
});

final nodeRegistryForFileLintsProvider =
    Provider.family<NodeRegistry, AnalyzedFile>((ref, file) {
  final rules = ref.watch(scopedLintRulesForFileProvider(file));
  return NodeRegistry(rules);
});

final nodeRegistryForFileAssistsProvider =
    Provider.family<NodeRegistry, AnalyzedFile>((ref, file) {
  final rules = ref.watch(scopedAssistRulesForFileProvider(file));
  return NodeRegistry(rules);
});
