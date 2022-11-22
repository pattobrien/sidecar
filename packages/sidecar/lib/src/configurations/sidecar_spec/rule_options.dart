import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../utils/json_utils/glob_json_util.dart';

part 'rule_options.freezed.dart';
part 'rule_options.g.dart';

@freezed
class RuleOptions with _$RuleOptions {
  const factory RuleOptions({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    bool? enabled,
  }) = _RuleOptions;

  const RuleOptions._();

  factory RuleOptions.fromJson(Map<String, dynamic> json) =>
      _$RuleOptionsFromJson(json);
}
