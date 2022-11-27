import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../utils/json_utils/glob_json_util.dart';
import 'rule_options.dart';

part 'package_options.g.dart';
part 'package_options.freezed.dart';

@freezed
class PackageOptions with _$PackageOptions {
  const PackageOptions._();
  const factory PackageOptions.lint({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    Map<String, LintOptions>? rules,
  }) = LintPackageOptions;

  const factory PackageOptions.assist({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    Map<String, AssistOptions>? rules,
  }) = AssistPackageOptions;

  factory PackageOptions.fromJson(Map<String, dynamic> json) =>
      _$PackageOptionsFromJson(json);

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

// @JsonSerializable(anyMap: true, includeIfNull: false)
// class PackageOptions {
//   const PackageOptions({
//     this.includes,
//     this.excludes,
//     this.rules,
//   });

//   factory PackageOptions.fromJson(Map json) => _$PackageOptionsFromJson(json);
//   Map<String, dynamic> toJson() => _$PackageOptionsToJson(this);

//   @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
//   final List<Glob>? includes;
//   @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
//   final List<Glob>? excludes;
//   final Map<String, RuleOptions>? rules;
// }

// @JsonSerializable(anyMap: true, includeIfNull: false)
// class AssistPackageOptions extends PackageOptions {
//   const AssistPackageOptions({
//     super.excludes,
//     super.includes,
//     this.rules,
//   });

//   factory AssistPackageOptions.fromJson(Map<String, dynamic> json) =>
//       _$AssistPackageOptionsFromJson(json);

//   @override
//   Map<String, dynamic> toJson() => _$AssistPackageOptionsToJson(this);

//   @override
//   final Map<String, AssistOptions>? rules;
// }

// @JsonSerializable(anyMap: true, includeIfNull: false)
// class LintPackageOptions extends PackageOptions {
//   const LintPackageOptions({
//     super.excludes,
//     super.includes,
//     this.rules,
//   });

//   factory LintPackageOptions.fromJson(Map<String, dynamic> json) =>
//       _$LintPackageOptionsFromJson(json);

//   @override
//   Map<String, dynamic> toJson() => _$LintPackageOptionsToJson(this);

//   @override
//   final Map<String, LintOptions>? rules;
// }
