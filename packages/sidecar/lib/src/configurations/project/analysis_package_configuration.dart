import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../yaml_parsers/yaml_parsers.dart';
import 'analysis_configuration.dart';

part 'analysis_package_configuration.freezed.dart';

@freezed
class AnalysisPackageConfiguration with _$AnalysisPackageConfiguration {
  const AnalysisPackageConfiguration._();

  const factory AnalysisPackageConfiguration.lint({
    required String packageName,
    required SourceSpan packageNameSpan,
    required Map<String, LintConfiguration> lints,
    @Default(<Glob>[]) List<Glob> includes,
    @Default(<YamlSourceError>[]) List<YamlSourceError> sourceErrors,
  }) = LintPackageConfiguration;

  const factory AnalysisPackageConfiguration.assist({
    required String packageName,
    required SourceSpan packageNameSpan,
    required Map<String, AssistConfiguration> assists,
    @Default(<Glob>[]) List<Glob> includes,
    @Default(<YamlSourceError>[]) List<YamlSourceError> sourceErrors,
  }) = AssistPackageConfiguration;

  factory AnalysisPackageConfiguration.fromYamlMap(
    YamlMap yamlMap, {
    required SidecarBaseType type,
    required String packageName,
    required SourceSpan packageNameSpan,
  }) {
    switch (type) {
      case SidecarBaseType.lint:
        return AnalysisPackageConfiguration.lint(
          packageNameSpan: packageNameSpan,
          packageName: packageName,
          lints: yamlMap.nodes
              .map<String, LintConfiguration>((dynamic key, value) {
            // final dynamic extractedValue = value.value;
            final yamlKey = key as YamlScalar;
            if (value is YamlMap) {
              final lintConfigurationErrors = <YamlSourceError>[];

              final configuration =
                  value.parseConfiguration().fold((l) => l, (r) {
                lintConfigurationErrors.addAll(r);
                return null;
              });

              final severity = value.parseSeverity().fold((l) => l, (r) {
                lintConfigurationErrors.addAll(r);
                return null;
              });

              final includes = value.parseGlobIncludes().fold((l) => l, (r) {
                lintConfigurationErrors.addAll(r);
                return null;
              });

              final enabled = value.parseEnabled().fold((l) => l, (r) {
                lintConfigurationErrors.addAll(r);
                return null;
              });

              return MapEntry(
                yamlKey.value as String,
                LintConfiguration(
                  id: yamlKey.value as String,
                  includes: includes,
                  severity: severity,
                  enabled: enabled,
                  configuration: configuration,
                  sourceErrors: lintConfigurationErrors,
                  packageName: packageName,
                  lintNameSpan: yamlKey.span,
                ),
              );
            } else if (value is YamlScalar) {
              final dynamic scalarValue = value.value;
              if (scalarValue is bool) {
                return MapEntry(
                  yamlKey.value as String,
                  LintConfiguration(
                    lintNameSpan: yamlKey.span,
                    packageName: packageName,
                    id: yamlKey.value as String,
                    enabled: scalarValue,
                  ),
                );
              }
              if (scalarValue == null) {
                return MapEntry(
                  yamlKey.value as String,
                  LintConfiguration(
                    lintNameSpan: yamlKey.span,
                    packageName: packageName,
                    id: yamlKey.value as String,
                  ),
                );
              }
            }
            return MapEntry(
              yamlKey.value as String,
              LintConfiguration(
                lintNameSpan: yamlKey.span,
                packageName: packageName,
                id: yamlKey.value as String,
                sourceErrors: <YamlSourceError>[
                  YamlSourceError(
                      sourceSpan: yamlKey.span,
                      message:
                          'Lint definition should be of type null, bool, or map')
                ],
              ),
            );
          }),
        );
      case SidecarBaseType.assist:
        return AnalysisPackageConfiguration.assist(
          packageNameSpan: packageNameSpan,
          packageName: packageName,
          assists: yamlMap.nodes
              .map<String, AssistConfiguration>((dynamic key, node) {
            final yamlKey = key as YamlScalar;
            if (node is YamlMap) {
              final editConfigurationErrors = <YamlSourceError>[];
              final configuration =
                  node.parseConfiguration().fold((map) => map, (errors) {
                editConfigurationErrors.addAll(errors);
                return null;
              });

              final includes =
                  node.parseGlobIncludes().fold((map) => map, (errors) {
                editConfigurationErrors.addAll(errors);
                return null;
              });

              final enabled = node.parseEnabled().fold((map) => map, (errors) {
                editConfigurationErrors.addAll(errors);
                return null;
              });

              return MapEntry(
                yamlKey.value as String,
                AssistConfiguration(
                  lintNameSpan: yamlKey.span,
                  packageName: packageName,
                  id: yamlKey.value as String,
                  configuration: configuration,
                  enabled: enabled,
                  includes: includes,
                  sourceErrors: editConfigurationErrors,
                ),
              );
            } else if (node is YamlScalar) {
              final dynamic scalarValue = node.value;
              if (scalarValue is bool) {
                return MapEntry(
                  yamlKey.value as String,
                  AssistConfiguration(
                    lintNameSpan: yamlKey.span,
                    packageName: packageName,
                    id: yamlKey.value as String,
                    enabled: scalarValue,
                  ),
                );
              }
              if (scalarValue == null) {
                return MapEntry(
                  yamlKey.value as String,
                  AssistConfiguration(
                    lintNameSpan: yamlKey.span,
                    packageName: packageName,
                    id: yamlKey.value as String,
                  ),
                );
              }
            }
            return MapEntry(
              yamlKey.value as String,
              AssistConfiguration(
                packageName: packageName,
                lintNameSpan: yamlKey.span,
                id: yamlKey.value as String,
                sourceErrors: <YamlSourceError>[
                  YamlSourceError(
                      sourceSpan: yamlKey.span,
                      message:
                          'CodeEdit definition should be of type null, bool, or map')
                ],
              ),
            );
          }),
        );
    }
  }
}
