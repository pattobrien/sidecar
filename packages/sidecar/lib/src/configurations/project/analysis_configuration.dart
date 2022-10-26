import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:glob/glob.dart';
import 'package:recase/recase.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../../rules/rules.dart';
import '../builders/builders.dart';

part 'analysis_configuration.freezed.dart';

@freezed
class AnalysisConfiguration with _$AnalysisConfiguration {
  const AnalysisConfiguration._();

  const factory AnalysisConfiguration.lint({
    required String id,
    required String packageName,
    required SourceSpan lintNameSpan,
    LintSeverity? severity,
    List<Glob>? includes,
    YamlMap? configuration,
    bool? enabled,
    @Default(<SidecarConfigException>[])
        List<SidecarConfigException> sourceErrors,
  }) = LintConfiguration;

  const factory AnalysisConfiguration.assist({
    required String id,
    required String packageName,
    required SourceSpan lintNameSpan,
    List<Glob>? includes,
    YamlMap? configuration,
    bool? enabled,
    @Default(<SidecarConfigException>[])
        List<SidecarConfigException> sourceErrors,
  }) = AssistConfiguration;
}

extension AnalysisConfigurationX on AnalysisConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(id).pascalCase;
}
