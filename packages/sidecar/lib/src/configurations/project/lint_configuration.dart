import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

import '../../../sidecar.dart';

part 'lint_configuration.g.dart';

@JsonSerializable(anyMap: true)
class LintConfiguration {
  const LintConfiguration({
    required this.packageName,
    required this.lintId,
    required this.configuration,
    this.enabled,
    this.includes,
    this.severity,
  });

  factory LintConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LintConfigurationFromJson(json);

  final String packageName;
  final String lintId;
  final bool? enabled;

  final Map<dynamic, dynamic> configuration;

  @JsonKey(fromJson: globsFromJson, toJson: globsToJson)
  final List<Glob>? includes;

  @JsonKey(fromJson: ruleTypeFromJson, toJson: ruleTypeToJson)
  final LintRuleType? severity;
}

String? ruleTypeToJson(LintRuleType? type) => type?.name;
LintRuleType? ruleTypeFromJson(String? type) =>
    type != null ? LintRuleTypeX.fromString(type) : null;

String globToJson(Glob glob) => glob.pattern;
List<String>? globsToJson(List<Glob>? globs) =>
    globs?.map((e) => e.pattern).toList();

Glob globFromJson(String glob) => Glob(glob);
List<Glob>? globsFromJson(List<String>? globs) => globs?.map(Glob.new).toList();

extension LintConfigurationX on LintConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(lintId).pascalCase;
}
