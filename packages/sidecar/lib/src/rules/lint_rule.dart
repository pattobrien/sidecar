import 'lint_rule_type.dart';
import 'base_rule.dart';

abstract class LintRule extends BaseRule {
  LintRuleType get defaultType => LintRuleType.info;
  String? get url => null;
}
