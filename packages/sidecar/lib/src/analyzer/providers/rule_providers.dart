import 'package:riverpod/riverpod.dart';

import '../../../context/context.dart';
import '../../protocol/analyzed_file.dart';
import '../../rules/base_rule.dart';
import '../../services/rule_initialization_service.dart';
import '../analyzer_logger.dart';
import '../ast/ast.dart';
import '../context/rule_analyzed_file.dart';
import '../sidecar_analyzer.dart';
import 'results_providers.dart';
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

  // for (final rule in rulesForFile) {
  //   //TODO: restrict updates to changes with rule/package config changes
  //   final ruleFile = RuleAnalyzedFile(rule: rule, file: file);
  //   final context = ref.watch(scopeForRuleProvider(ruleFile));
  //   rule.setConfig(context: context);
  // }

  // logger.fine('_scopedRulesForFileProvider ${rulesForFile.map((e) => e.code)}');
  return rulesForFile;
});

final scopeForRuleProvider =
    Provider.family<SidecarContext, RuleAnalyzedFile>((ref, ruleFile) {
  final rule = ruleFile.rule;
  final baseContext = ref.watch(sidecarContextProvider(ruleFile.file))!;
  // TODO: use RuleScope to restrict updates
  // final scope = ruleFile.rule.scope;
  // final scopedData = ref.watch(totalDataResultsProvider
  //     .select((value) => rule.scope.dataSelector(value)));
  // return baseContext.copyWith(data: scopedData.toSet());
  return baseContext;
});

final ProviderFamily<Set<Lint>, AnalyzedFile> scopedLintRulesForFileProvider =
    Provider.family<Set<Lint>, AnalyzedFile>((ref, file) {
  final lints = ref.watch(_scopedRulesForFileProvider(file)
      .select((value) => value.whereType<Lint>().toSet()));

  for (final lint in lints) {
    //TODO: restrict updates to changes with rule/package config changes
    final ruleFile = RuleAnalyzedFile(rule: lint, file: file);
    final context = ref.watch(scopeForRuleProvider(ruleFile));
    lint.setConfig(context: context);
  }
  return lints;
});

final scopedAssistRulesForFileProvider =
    Provider.family<Set<QuickAssist>, AnalyzedFile>((ref, file) {
  final assists = ref.watch(_scopedRulesForFileProvider(file)
      .select((value) => value.whereType<QuickAssist>().toSet()));

  for (final assist in assists) {
    //TODO: restrict updates to changes with rule/package config changes
    final context = ref.watch(sidecarContextProvider(file))!;
    assist.setConfig(context: context);
  }
  return assists;
});

final ProviderFamily<Set<Data>, AnalyzedFile> scopedDataRulesForFileProvider =
    Provider.family<Set<Data>, AnalyzedFile>((ref, file) {
  final dataRules = ref.watch(_scopedRulesForFileProvider(file)
      .select((value) => value.whereType<Data>().toSet()));

  for (final data in dataRules) {
    //TODO: restrict updates to changes with rule/package config changes
    final context = ref.watch(sidecarContextProvider(file))!;
    data.setConfig(context: context);
  }
  return dataRules;
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

final nodeRegistryForFileDataProvider =
    Provider.family<NodeRegistry, AnalyzedFile>((ref, file) {
  final rules = ref.watch(scopedDataRulesForFileProvider(file));
  return NodeRegistry(rules);
});
