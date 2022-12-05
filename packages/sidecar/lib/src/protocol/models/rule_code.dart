import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule_code.freezed.dart';
part 'rule_code.g.dart';

@freezed

/// Identify a particular sidecar rule, for lints, assists, etc.
class RuleCode with _$RuleCode {
  /// Identifier for a Sidecar Lint rule
  const factory RuleCode.lint(
    String id, {
    required String package,
    String? url,
  }) = LintCode;

  /// Identifier for a Sidecar Assist rule
  const factory RuleCode.assist(
    String id, {
    required String package,
    String? url,
  }) = AssistCode;

  const RuleCode._();

  factory RuleCode.fromJson(Map<String, dynamic> json) =>
      _$RuleCodeFromJson(json);
}
