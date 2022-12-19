import '../../../rules/rules.dart';
import '../../protocol/models/models.dart';

class ExpectedLint {
  ExpectedLint(
    this.code,
    this.offset,
    this.length, {
    this.severity,
  });
  final RuleCode code;
  final int offset;
  final int length;
  final LintSeverity? severity;
}
