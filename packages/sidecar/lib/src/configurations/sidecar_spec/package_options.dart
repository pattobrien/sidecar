import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../utils/json_utils/glob_json_util.dart';
import 'rule_options.dart';

part 'package_options.freezed.dart';
part 'package_options.g.dart';

@freezed
class PackageOptions with _$PackageOptions {
  const factory PackageOptions({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    Map<String, RuleOptions>? rules,
  }) = _PackageOptions;

  const PackageOptions._();

  factory PackageOptions.fromJson(Map<String, dynamic> json) =>
      _$PackageOptionsFromJson(json);
}
