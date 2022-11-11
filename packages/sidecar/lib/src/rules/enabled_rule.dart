import 'package:freezed_annotation/freezed_annotation.dart';

import '../configurations/configurations.dart';
import 'rules.dart';

@immutable
class EnabledRule {
  const EnabledRule(
    this.rule, {
    required this.configuration,
    required this.packageConfiguration,
  });

  final BaseRule rule;
  final AnalysisPackageConfiguration? packageConfiguration;
  final AnalysisConfiguration? configuration;

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
