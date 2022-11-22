import 'package:freezed_annotation/freezed_annotation.dart';

import '../configurations/sidecar_spec/package_options.dart';
import '../configurations/sidecar_spec/rule_options.dart';
import 'rules.dart';

@immutable
class EnabledRule {
  const EnabledRule(
    this.rule, {
    required this.configuration,
    required this.packageConfiguration,
  });

  final BaseRule rule;
  final PackageOptions? packageConfiguration;
  final RuleOptions? configuration;

  @override
  bool operator ==(Object other) =>
      other is EnabledRule &&
      rule.code == other.rule.code &&
      packageConfiguration == other.packageConfiguration &&
      configuration == configuration;

  @override
  int get hashCode =>
      Object.hash(runtimeType, rule.code, packageConfiguration, configuration);
}
