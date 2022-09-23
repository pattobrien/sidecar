import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

import '../../models/lint_rule.dart';
import 'parsers.dart';

part 'edit_configuration.g.dart';

@JsonSerializable(anyMap: true)
class EditConfiguration {
  const EditConfiguration({
    required this.packageName,
    required this.id,
    required this.configuration,
    this.enabled,
    this.includes,
    this.severity,
  });

  // factory EditConfiguration.fromJson(Map<String, dynamic> json) =>
  //     _$EditConfigurationFromJson(json);

  final String packageName;
  final String id;

  final bool? enabled;

  final Map<dynamic, dynamic> configuration;

  @JsonKey(fromJson: globsFromJson, toJson: globsToJson)
  final List<Glob>? includes;

  @JsonKey(fromJson: ruleTypeFromJson, toJson: ruleTypeToJson)
  final LintRuleType? severity;
}

extension EditConfigurationX on EditConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(id).pascalCase;
}
