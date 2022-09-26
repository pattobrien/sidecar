import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

import '../../models/models.dart';
import 'errors.dart';

part 'analysis_configuration.freezed.dart';

@freezed
class AnalysisConfiguration with _$AnalysisConfiguration {
  const AnalysisConfiguration._();

  const factory AnalysisConfiguration.lint({
    required String id,
    required String packageName,
    LintRuleType? severity,
    List<Glob>? includes,
    YamlMap? configuration,
    bool? enabled,
    @Default(<YamlSourceError>[]) List<YamlSourceError> sourceErrors,
  }) = LintConfiguration;

  const factory AnalysisConfiguration.assist({
    required String id,
    required String packageName,
    List<Glob>? includes,
    YamlMap? configuration,
    bool? enabled,
    @Default(<YamlSourceError>[]) List<YamlSourceError> sourceErrors,
  }) = AssistConfiguration;
}

extension AnalysisConfigurationX on AnalysisConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(id).pascalCase;

  IdType get type =>
      map(lint: (_) => IdType.lintRule, assist: (_) => IdType.codeEdit);
}
