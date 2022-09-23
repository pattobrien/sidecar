import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

import '../../models/lint_rule.dart';
import 'parsers.dart';

part 'lint_configuration.g.dart';

@JsonSerializable(anyMap: true)
class LintConfiguration {
  const LintConfiguration({
    required this.packageName,
    required this.id,
    required this.configuration,
    this.enabled,
    this.includes,
    this.severity,
  });

  // factory LintConfiguration.fromJson(Map<String, dynamic> json) =>
  //     _$LintConfigurationFromJson(json);

  final String packageName;
  final String id;
  final bool? enabled;

  final Map<dynamic, dynamic> configuration;

  @JsonKey(fromJson: globsFromJson, toJson: globsToJson)
  final List<Glob>? includes;

  @JsonKey(fromJson: ruleTypeFromJson, toJson: ruleTypeToJson)
  final LintRuleType? severity;
}

extension LintConfigurationX on LintConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(id).pascalCase;
}
