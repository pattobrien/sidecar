import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../../utils/json_utils/glob_json_util.dart';
import '../builders/exceptions.dart';
import '../builders/new_exceptions.dart';
import '../yaml_parsers/yaml_parsers.dart';

part 'analysis_configuration.freezed.dart';
part 'analysis_configuration.g.dart';

@freezed
class AnalysisConfiguration with _$AnalysisConfiguration {
  const AnalysisConfiguration._();

  @JsonSerializable(anyMap: true)
  const factory AnalysisConfiguration.lint({
    LintSeverity? severity,
    @JsonKey(toJson: globsToString, fromJson: globsFromString)
        List<Glob>? includes,
    Map<dynamic, dynamic>? configuration,
    bool? enabled,
    @Default(<SidecarNewException>[]) List<SidecarNewException> errors,
  }) = LintConfiguration;

  @JsonSerializable(anyMap: true)
  const factory AnalysisConfiguration.assist({
    @JsonKey(toJson: globsToString, fromJson: globsFromString)
        List<Glob>? includes,
    Map<dynamic, dynamic>? configuration,
    bool? enabled,
    @Default(<SidecarNewException>[]) List<SidecarNewException> errors,
  }) = AssistConfiguration;

  factory AnalysisConfiguration.fromYaml(YamlNode yamlNode, RuleType ruleType) {
    switch (ruleType) {
      case RuleType.lint:
        return parseLintFromYaml(yamlNode);
      case RuleType.assist:
        return parseAssistFromYaml(yamlNode);

      default:
        throw UnimplementedError('AnalysisConfiguration invalid yaml');
    }
  }
}

LintConfiguration parseLintFromYaml(YamlNode yaml) {
  final value = yaml;
  if (value is YamlMap) {
    final configuration = value.parseConfiguration();
    final severity = value.parseSeverity();
    final includes = value.parseGlobIncludes();
    final enabled = value.parseEnabled();

    return LintConfiguration(
      includes: includes.item1,
      severity: severity.item1,
      enabled: enabled.item1,
      configuration: configuration.item1,
      errors: [
        ...includes.item2,
        ...severity.item2,
        ...configuration.item2,
        ...enabled.item2,
      ],
    );
  } else if (value is YamlScalar) {
    final dynamic scalarValue = value.value;
    if (scalarValue is bool) {
      return LintConfiguration(
        enabled: scalarValue,
      );
    }
    if (scalarValue == null) {
      return const LintConfiguration();
    }
  }
  // return MapEntry(
  //   yamlKey.value as String,
  return LintConfiguration(
    // lintNameSpan: yamlKey.span,
    // packageName: packageName,
    // id: yamlKey.value as String,
    errors: <SidecarNewException>[
      SidecarNewException.rule(
        sourceSpan: value.span,
        message: 'Lint definition should be of type null, bool, or map',
      ),
    ],
    // ),
  );
}

AssistConfiguration parseAssistFromYaml(YamlNode yaml) {
  final value = yaml;
  if (value is YamlMap) {
    final configuration = value.parseConfiguration();
    final includes = value.parseGlobIncludes();
    final enabled = value.parseEnabled();

    return AssistConfiguration(
      includes: includes.item1,
      // severity: severity.item1,
      enabled: enabled.item1,
      configuration: configuration.item1,
      // sourceErrors: [
      //   ...includes.item2,
      //   ...severity.item2,
      //   ...configuration.item2,
      //   ...enabled.item2,
      // ],
    );
  } else if (value is YamlScalar) {
    final dynamic scalarValue = value.value;
    if (scalarValue is bool) {
      return AssistConfiguration(
        enabled: scalarValue,
      );
    }
    if (scalarValue == null) {
      return const AssistConfiguration();
    }
  }
  // return MapEntry(
  //   yamlKey.value as String,
  return AssistConfiguration(
      // lintNameSpan: yamlKey.span,
      // packageName: packageName,
      // id: yamlKey.value as String,
      //   sourceErrors: <SidecarConfigException>[
      //     SidecarLintException(
      //       yamlKey,
      //       message: 'Lint definition should be of type null, bool, or map',
      //     ),
      //   ],
      // ),
      );
}
// extension AnalysisConfigurationX on AnalysisConfiguration {
//   String get filePath => '$packageName/$packageName.dart';
//   String get className => ReCase(id).pascalCase;
// }
