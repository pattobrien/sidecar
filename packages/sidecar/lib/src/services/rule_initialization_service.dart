import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../analyzer/ast/ast.dart';
import '../configurations/sidecar_spec/sidecar_spec.dart';
import '../protocol/analyzed_file.dart';
import '../rules/rules.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

/// Service for initializing Sidecar Rules based on SidecarSpec configuration.
class RuleInitializationService {
  /// Returns all of the rules that match sidecar spec for a particular file.
  Set<BaseRule> constructRulesForFile(
    AnalyzedFile file,
    SidecarSpec spec,
    List<SidecarBaseConstructor> constructors,
  ) {
    final rules = constructors.map((e) => e());
    final packageOptions = [...?spec.assists?.entries, ...?spec.lints?.entries];
    final rulesForFile = <BaseRule>{};
    for (final packageOption in packageOptions) {
      final packageId = packageOption.key;
      final ruleOptionEntries = packageOption.value.ruleOptions?.entries ?? [];

      for (final ruleEntry in ruleOptionEntries) {
        final ruleId = ruleEntry.key;
        final thisRule = rules.firstWhereOrNull((rule) {
          return rule.code.id == ruleId && rule.code.package == packageId;
        });

        if (thisRule == null) {
          logger.info('getRulesForFile $ruleId is null');
          continue; // this should throw an error on sidecar.yaml
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
          logger.info('getRulesForFile $ruleId is not included');
          continue;
        }

        final isFileExcluded = isExcluded(file.relativePath,
            [...rootExcludes, ...?packageExcludes, ...?ruleExcludes]);
        if (isFileExcluded) {
          logger.info('getRulesForFile $ruleId is excluded');
          continue;
        }

        rulesForFile.add(thisRule);
      }
    }

    logger.info(
        'getRulesForFile $file ${rulesForFile.length} ${rulesForFile.map((e) => e.code)}');
    return rulesForFile;
  }

  Set<BaseRule> getRulesForActiveProject(
    SidecarSpec config,
    List<SidecarBaseConstructor> constructors,
  ) {
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

  // NodeRegistry createNodeRegistry({
  //   required String file,
  //   required SidecarSpec config,
  //   required Set<BaseRule> rules,
  // }) {
  //   final registry = NodeRegistry(rules);
  //   // removed: registerVisitors is now handled inside registry
  //   // registerVisitorsWithRegistry(rules, registry);
  //   return registry;
  // }

  @Deprecated('registerVisitors is now handled inside registry')
  void registerVisitorsWithRegistry(
    Set<BaseRule> rules,
    NodeRegistry registry,
  ) {
    // ignore: prefer_iterable_wheretype
    for (final rule in rules) {
      rule.initializeVisitor(registry);
    }
  }
}

final ruleInitializationServiceProvider = Provider(
  (_) => RuleInitializationService(),
  name: 'ruleInitializationServiceProvider',
  dependencies: const [],
);
