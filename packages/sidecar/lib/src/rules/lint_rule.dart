import 'base_rule.dart';
import 'lint_severity.dart';

abstract class LintRule extends BaseRule {
  LintSeverity get defaultType => LintSeverity.info;
  String? get url => null;
}
