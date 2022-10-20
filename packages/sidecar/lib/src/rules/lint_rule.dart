import 'lint_rule_type.dart';
import 'sidecar_base.dart';

abstract class LintRule extends SidecarBase {
  LintRuleType get defaultType => LintRuleType.info;
  String? get url => null;
}
