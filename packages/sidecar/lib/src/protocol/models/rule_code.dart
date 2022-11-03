import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule_code.freezed.dart';
part 'rule_code.g.dart';

@freezed

/// Identify a particular sidecar rule, for lints, assists, etc.
class RuleCode with _$RuleCode {
  const factory RuleCode({
    required RuleType type,
    required String code,
    required String packageName,
    String? url,
  }) = _RuleCode;

  factory RuleCode.fromJson(Map<String, dynamic> json) =>
      _$RuleCodeFromJson(json);

  const RuleCode._();
}

enum RuleType { lint, assist }
