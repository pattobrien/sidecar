import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../../rules/rules.dart';
import '../../utils/json_utils/glob_json_util.dart';

part 'rule_options.g.dart';
part 'rule_options.freezed.dart';

/// Base class for Lint and Assist configurations within sidecar.yaml files.
@freezed
class RuleOptions with _$RuleOptions {
  /// Lint rule configurations that are set within sidecar.yaml files.
  const factory RuleOptions.lint({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    bool? enabled,
    Map<dynamic, dynamic>? configuration,
    LintSeverity? severity,
  }) = LintOptions;

  /// Assist rule configurations that are set within sidecar.yaml files.
  const factory RuleOptions.assist({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    bool? enabled,
    Map<dynamic, dynamic>? configuration,
  }) = AssistOptions;

  /// Parse Lint and Assist rules from Json.
  factory RuleOptions.fromJson(Map<String, dynamic> json) =>
      _$RuleOptionsFromJson(json);

  const RuleOptions._();
}
