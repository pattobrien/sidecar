import 'models.dart';

abstract class LintRule extends SidecarBase {
  LintRuleType get defaultType => LintRuleType.info;
  String? get url => null;
}
