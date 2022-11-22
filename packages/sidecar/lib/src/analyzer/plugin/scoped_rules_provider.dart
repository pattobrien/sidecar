import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import '../../../rules/rules.dart';
import '../../rules/enabled_rule.dart';
import '../../rules/rules.dart';
import '../../protocol/analyzed_file.dart';
import 'plugin.dart';
import 'rule_provider.dart';

/// Given a particular file, get the rules whose globs permit analysis
///
/// This should only be rebuilt when active rules rebuild (i.e. indirectly on
/// project configuration rebuilds)
final _scopedRulesForFileProvider =
    Provider.family<List<EnabledRule>, AnalyzedFileWithContext>((ref, file) {
  final activeRules = ref.watch(activeRulesProvider);
  final scopedRules = activeRules.where((rule) {
    final configuredGlobs = rule.configuration?.includes;
    final configuredPackageGlobs = rule.packageConfiguration?.includes;
    //TODO: globs should actually be calculated from:
    // a) rule / package defaults
    // b) configuration globs (project, package, rule includes/excludes)
    // for now we'll create a fake set of globs:
    final fakeGlobs = <Glob>{Glob('bin/**'), Glob('lib/**')};

    final isMatch = fakeGlobs.any((glob) => glob.matches(file.relativePath));
    return isMatch;
  }).toList();

  return scopedRules;
});

final scopedVisitorForFileProvider =
    Provider.family<List<LintMixin>, AnalyzedFileWithContext>((ref, file) {
  // initialize rules with visitors
  final scopedRules = ref.watch(_scopedRulesForFileProvider(file));
  final registry = ref.watch(nodeRegistryForFileProvider(file));
  final visitorRules = scopedRules.where((e) => e.rule is LintMixin);
  return visitorRules.map((rule) {
    final baseRule = rule.rule as BaseRuleVisitorMixin;

    final visitor = baseRule..initializeVisitor(registry);

    visitor.refresh(
      config: rule.configuration,
      packageConfig: rule.packageConfiguration,
    );

    return visitor as LintMixin;
  }).toList();
});

final scopedLintRulesForFileProvider =
    Provider.family<List<EnabledRule>, AnalyzedFileWithContext>(
  (ref, file) {
    // final registry = ref.watch(nodeRegistryForFileProvider(file));
    return ref.watch(_scopedRulesForFileProvider(file)
        .select((value) => value.where((e) => e.rule is LintMixin).toList()));
    // for (final rule in scopedRules.whereType<LintVisitor>()) {
    //   rule.initializeVisitor(registry);
    // }
  },
);

final scopedAssistRulesForFileProvider =
    Provider.family<List<EnabledRule>, AnalyzedFileWithContext>(
  (ref, arg) {
    return ref.watch(_scopedRulesForFileProvider(arg)
        .select((value) => value.where((e) => e.rule is AssistMixin).toList()));
  },
);

final scopedLintRulesWithVisitorsProvider =
    Provider.family<List<SidecarVisitor>, AnalyzedFileWithContext>((ref, file) {
  final scopedLintRules = ref.watch(scopedLintRulesForFileProvider(file));
  return scopedLintRules.whereType<SidecarVisitor>().toList();
});
