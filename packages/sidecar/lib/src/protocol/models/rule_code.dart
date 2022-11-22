import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule_code.freezed.dart';
part 'rule_code.g.dart';

@freezed

/// Identify a particular sidecar rule, for lints, assists, etc.
class RuleCode with _$RuleCode {
  const factory RuleCode.lint(
    String code, {
    required String package,
    Uri? url,
  }) = LintCode;

  const factory RuleCode.assist(
    String code, {
    required String package,
    Uri? url,
  }) = AssistCode;

  const RuleCode._();

  factory RuleCode.fromJson(Map<String, dynamic> json) =>
      _$RuleCodeFromJson(json);
}
