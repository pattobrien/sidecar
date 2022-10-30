import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../builders/builders.dart';
import 'analysis_configuration.dart';

part 'analysis_package_configuration.freezed.dart';

@freezed
class AnalysisPackageConfiguration with _$AnalysisPackageConfiguration {
  const AnalysisPackageConfiguration._();

  const factory AnalysisPackageConfiguration.lint({
    required Map<String, LintConfiguration> lints,
    @Default(<Glob>[]) List<Glob> includes,
    @Default(<SidecarConfigException>[])
        List<SidecarConfigException> sourceErrors,
  }) = LintPackageConfiguration;

  const factory AnalysisPackageConfiguration.assist({
    required Map<String, AssistConfiguration> assists,
    @Default(<Glob>[]) List<Glob> includes,
    @Default(<SidecarConfigException>[])
        List<SidecarConfigException> sourceErrors,
  }) = AssistPackageConfiguration;

  factory AnalysisPackageConfiguration.fromYamlMap(
    YamlMap yamlMap, {
    required RuleType type,
  }) {
    switch (type) {
      case RuleType.lint:
        return AnalysisPackageConfiguration.lint(
          lints: yamlMap.nodes
              .map<String, LintConfiguration>((dynamic key, value) {
            final yamlKey = key as YamlScalar;
            final config = AnalysisConfiguration.fromYaml(value, RuleType.lint);
            return MapEntry(
                yamlKey.value.toString(), config as LintConfiguration);
          }),
        );
      case RuleType.assist:
        return AnalysisPackageConfiguration.assist(
          assists: yamlMap.nodes
              .map<String, AssistConfiguration>((dynamic key, value) {
            final yamlKey = key as YamlScalar;
            final config =
                AnalysisConfiguration.fromYaml(value, RuleType.assist);
            return MapEntry(
                yamlKey.value.toString(), config as AssistConfiguration);
          }),
        );
    }
  }
}
