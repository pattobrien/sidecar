import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../../utils/json_utils/glob_json_util.dart';
import '../builders/new_exceptions.dart';
import '../yaml_parsers/yaml_parsers.dart';

part 'analysis_configuration.g.dart';

abstract class AnalysisConfiguration {
  const AnalysisConfiguration();

  Map<dynamic, dynamic>? get configuration;
  bool? get enabled;
  List<SidecarNewException> get errors;
  List<Glob>? get includes;
}

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class LintConfiguration extends AnalysisConfiguration {
  const LintConfiguration({
    this.severity,
    this.includes,
    this.configuration,
    this.enabled,
  }) : errors = const [];

  const LintConfiguration._({
    this.severity,
    this.includes,
    this.configuration,
    this.enabled,
    this.errors = const [],
  });

  factory LintConfiguration.fromJson(Object? json) => parseLintFromYaml(json);
  Map<dynamic, dynamic> toJson() => _$LintConfigurationToJson(this);

  final LintSeverity? severity;
  @override
  final Map<dynamic, dynamic>? configuration;
  @override
  final bool? enabled;
  @override
  final List<SidecarNewException> errors;

  @override
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  final List<Glob>? includes;
}

@JsonSerializable(anyMap: true, explicitToJson: true, includeIfNull: false)
class AssistConfiguration extends AnalysisConfiguration {
  const AssistConfiguration({
    this.includes,
    this.configuration,
    this.enabled,
  }) : errors = const [];

  factory AssistConfiguration.fromJson(Object? json) =>
      parseAssistFromYaml(json);

  const AssistConfiguration._({
    this.includes,
    this.configuration,
    this.enabled,
    this.errors = const [],
  });
  Map<dynamic, dynamic> toJson() => _$AssistConfigurationToJson(this);

  @override
  final Map<dynamic, dynamic>? configuration;
  @override
  final bool? enabled;
  @override
  final List<SidecarNewException> errors;

  @override
  @JsonKey(toJson: globsToString, fromJson: globsFromString)
  final List<Glob>? includes;
}

LintConfiguration parseLintFromYaml(Object? yaml) {
  final value = yaml;
  if (value is YamlMap) {
    final configuration = value.parseConfiguration();
    final severity = value.parseSeverity();
    final includes = value.parseGlobIncludes();
    final enabled = value.parseEnabled();

    return LintConfiguration._(
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
  return LintConfiguration._(
    // lintNameSpan: yamlKey.span,
    // packageName: packageName,
    // id: yamlKey.value as String,
    errors: <SidecarNewException>[
      // SidecarNewException.rule(
      //   sourceSpan: value.span,
      //   message: 'Lint definition should be of type null, bool, or map',
      // ),
    ],
    // ),
  );
}

AssistConfiguration parseAssistFromYaml(Object? yaml) {
  final value = yaml;
  if (value is YamlMap) {
    final configuration = value.parseConfiguration();
    final includes = value.parseGlobIncludes();
    final enabled = value.parseEnabled();

    return AssistConfiguration._(
      includes: includes.item1,
      enabled: enabled.item1,
      configuration: configuration.item1,
      errors: [
        ...includes.item2,
        ...configuration.item2,
        ...enabled.item2,
      ],
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
  return const AssistConfiguration._(
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
