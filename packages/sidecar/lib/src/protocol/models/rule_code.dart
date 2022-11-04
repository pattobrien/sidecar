import 'package:freezed_annotation/freezed_annotation.dart';

import '../../rules/rules.dart';

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

  const RuleCode._();

  factory RuleCode.fromJson(Map<String, dynamic> json) =>
      _$RuleCodeFromJson(json);
}

enum RuleType { lint, assist }

extension BaseRuleX on BaseRule {
  RuleCode get ruleCode {
    final thisRule = this;
    if (thisRule is LintRule) {
      return RuleCode(
        type: RuleType.lint,
        code: code,
        packageName: packageName,
        url: thisRule.url,
      );
    } else if (this is AssistRule) {
      return RuleCode(
        type: RuleType.assist,
        code: code,
        packageName: packageName,
      );
    } else {
      throw UnimplementedError('expected either an AssistRule or LintRule.');
    }
  }
}
