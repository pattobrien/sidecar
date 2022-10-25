import 'package:cli_util/cli_logging.dart';

import '../configurations/configurations.dart';

enum LintRuleType { info, warning, error }

extension LintRuleTypeX on LintRuleType {
  static LintRuleType fromString(String string) {
    if (string == LintRuleType.error.name) {
      return LintRuleType.error;
    }
    if (string == LintRuleType.warning.name) {
      return LintRuleType.warning;
    }
    if (string == LintRuleType.info.name) {
      return LintRuleType.info;
    }
    throw InvalidSeverityException(string);
  }

  // used to colorize CLI output
  String get ansi {
    final ansi = Ansi(true);
    switch (this) {
      case LintRuleType.info:
        return name;
      case LintRuleType.warning:
        return '${ansi.yellow}$name${ansi.none}';
      case LintRuleType.error:
        return '${ansi.red}$name${ansi.none}';
    }
  }
}
