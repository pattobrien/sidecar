import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../../sidecar.dart';
import '../../utils/json_utils/glob_json_util.dart';

part 'rule_options.g.dart';
// part 'rule_options.freezed.dart';

// @freezed
// class RuleOptions with _$RuleOptions {
//   const RuleOptions._();
//   const factory RuleOptions.lint({
//     @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
//         List<Glob>? includes,
//     @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
//         List<Glob>? excludes,
//     bool? enabled,
//     Map<dynamic, dynamic>? configuration,
//     LintSeverity? severity,
//   }) = LintRuleOptions;

//   const factory RuleOptions.assist({
//     @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
//         List<Glob>? includes,
//     @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
//         List<Glob>? excludes,
//     bool? enabled,
//     Map<dynamic, dynamic>? configuration,
//   }) = AssistRuleOptions;

//   factory RuleOptions.fromJson(Map<String, dynamic> json) =>
//       _$RuleOptionsFromJson(json);
// }

@JsonSerializable(anyMap: true, includeIfNull: false)
class RuleOptions {
  const RuleOptions({
    this.includes,
    this.excludes,
    this.enabled,
    this.configuration,
  });

  factory RuleOptions.fromJson(Map<String, dynamic> json) =>
      _$RuleOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$RuleOptionsToJson(this);

  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? includes;
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  final List<Glob>? excludes;
  final bool? enabled;
  final Map<dynamic, dynamic>? configuration;
}

@JsonSerializable(anyMap: true, includeIfNull: false)
class LintOptions extends RuleOptions {
  const LintOptions({
    this.severity,
    super.configuration,
    super.enabled,
    super.excludes,
    super.includes,
  });

  factory LintOptions.fromJson(Map<String, dynamic> json) =>
      _$LintOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LintOptionsToJson(this);

  final LintSeverity? severity;
}

@JsonSerializable()
class AssistOptions extends RuleOptions {
  const AssistOptions({
    super.configuration,
    super.enabled,
    super.excludes,
    super.includes,
  });

  factory AssistOptions.fromJson(Map<String, dynamic> json) =>
      _$AssistOptionsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssistOptionsToJson(this);
}
