import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/ast/ast.dart';
import '../configurations/sidecar_spec/sidecar_spec_base.dart';
import '../protocol/analyzed_file.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

/// Service for initializing Sidecar Rules based on SidecarSpec configuration.
class RuleInitializationService {
  /// Returns all of the rules that match sidecar spec for a particular file.
  Set<BaseRule> getRulesForFile({
    required AnalyzedFile file,
    required SidecarSpec spec,
    required List<SidecarBaseConstructor> constructors,
  }) {
    final rules = constructors.map((e) => e());
    final packageOptions = [...?spec.assists?.entries, ...?spec.lints?.entries];
    final rulesForFile = <BaseRule>{};
    for (final packageOption in packageOptions) {
      final packageId = packageOption.key;
      final ruleOptionEntries = packageOption.value.ruleOptions?.entries ?? [];

      for (final ruleEntry in ruleOptionEntries) {
        final ruleId = ruleEntry.key;
        final thisRule = rules.firstWhereOrNull((rule) {
          return rule.code.code == ruleId && rule.code.package == packageId;
        });

        if (thisRule == null) {
          print('getRulesForFile $ruleId is null');
          continue; // this should throw an error
        }

        // check if rules are configured

        final rootExcludes = spec.excludes ?? SidecarSpec.defaultExcludes;
        final rootIncludes = spec.includes ?? SidecarSpec.defaultIncludes;
        final packageIncludes = packageOption.value.includes;
        final packageExcludes = packageOption.value.excludes;
        final ruleIncludes = ruleEntry.value.includes ?? thisRule.includes;
        final ruleExcludes = ruleEntry.value.excludes ?? thisRule.excludes;

        final isFileIncluded = isIncluded(file.relativePath,
            [...rootIncludes, ...?packageIncludes, ...?ruleIncludes]);
        if (!isFileIncluded) {
          print('getRulesForFile $ruleId is not included');
          continue;
        }

        final isFileExcluded = isExcluded(file.relativePath,
            [...rootExcludes, ...?packageExcludes, ...?ruleExcludes]);
        if (isFileExcluded) {
          print('getRulesForFile $ruleId is excluded');
          continue;
        }

        rulesForFile.add(thisRule);
      }
    }

    print(
        'getRulesForFile $file ${rulesForFile.length} ${rulesForFile.map((e) => e.code)}');
    return rulesForFile;
  }

  Set<BaseRule> getRulesForActiveProject({
    required SidecarSpec config,
    required List<SidecarBaseConstructor> constructors,
  }) {
    final rules = constructors.map((e) => e());
    return rules
        .map((rule) {
          final ruleConfig = config.getConfigurationForCode(rule.code);

          // rule was not included in yaml, or was explicitly disabled,
          // so it shouldnt be initialized
          if (ruleConfig == null || ruleConfig.enabled == false) return null;

          // rule.setConfig(sidecarSpec: config);
          // TODO: catch configuration errors
          // if (rule is Configuration) {  }

          logger.finer('activating ${rule.code}');

          return rule;
        })
        .whereNotNull()
        .toSet();
  }

  NodeRegistry createNodeRegistry({
    required String file,
    required SidecarSpec config,
    required Set<BaseRule> rules,
  }) {
    final registry = NodeRegistry();
    registerVisitorsWithRegistry(rules, registry);
    return registry;
  }

  void registerVisitorsWithRegistry(
    Set<BaseRule> rules,
    NodeRegistry registry,
  ) {
    // ignore: prefer_iterable_wheretype
    for (final rule in rules) {
      rule.initializeVisitor(registry);
    }
  }

  // List<BaseRule> constructRules(
  //   SidecarSpec config,
  //   List<SidecarBaseConstructor> ruleConstructors,
  // ) {
  //   logger.finer('lint packages init: ${config.lints?.length ?? 0}');
  //   logger.finer('assist packages init: ${config.assists?.length ?? 0}');
  //   return ruleConstructors
  //       .map((ruleConstructor) {
  //         final rule = ruleConstructor();
  //         final ruleConfig = config.getConfigurationForCode(rule.code);

  //         // rule was not included in yaml, or was explicitly disabled,
  //         // so it shouldnt be initialized
  //         if (ruleConfig == null || ruleConfig.enabled == false) return null;

  //         // if (rule is Configuration) {
  //         rule.setConfig(sidecarSpec: config);
  //         // }

  //         logger.finer('activating ${rule.code}');

  //         return rule;
  //       })
  //       .whereNotNull()
  //       .toList();
  // }
}

final ruleInitializationServiceProvider = Provider(
  (_) => RuleInitializationService(),
  name: 'ruleInitializationServiceProvider',
  dependencies: const [],
);
