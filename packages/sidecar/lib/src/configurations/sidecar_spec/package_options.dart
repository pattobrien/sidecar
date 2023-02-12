import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../utils/json_utils/glob_json_util.dart';
import 'rule_options.dart';

part 'package_options.g.dart';
part 'package_options.freezed.dart';

@Freezed(
  unionKey: null,
  fromJson: false,
  toJson: true,
  unionValueCase: FreezedUnionCase.none,
)

/// Base class for Rule Package configurations within sidecar.yaml files.
class PackageOptions with _$PackageOptions {
  /// Lint rule package configurations within sidecar.yaml files.
  const factory PackageOptions.lint({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    Map<String, LintOptions>? rules,
  }) = LintPackageOptions;

  /// Assist rule package configurations within sidecar.yaml files.
  const factory PackageOptions.assist({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    Map<String, AssistOptions>? rules,
  }) = AssistPackageOptions;

  /// Create [PackageOptions] from a json object.
  // factory PackageOptions.fromJson(Map<String, dynamic> json) =>
  //     _$PackageOptionsFromJson(json);

  const PackageOptions._();

  Map<String, RuleOptions>? get ruleOptions {
    final package = this;
    if (package is LintPackageOptions) {
      return package.rules;
    }
    if (package is AssistPackageOptions) {
      return package.rules;
    }
    throw StateError('invalid package options');
  }
}
