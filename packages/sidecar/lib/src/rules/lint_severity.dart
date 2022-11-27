import 'package:cli_util/cli_logging.dart';

import '../configurations/configurations.dart';

/// Severity level for Lint rules.
enum LintSeverity {
  /// Lowest severity, equates to a blue underline in an IDE.
  info,

  /// A yellow underline in an IDE.
  warning,

  /// A red underline in an IDE, code will not compile with an error.
  error,
}

/// Utilities for outputing LintSeverity.
extension LintSeverityX on LintSeverity {
  /// Generate enum from it's string representation.
  static LintSeverity fromString(String string) {
    if (string == LintSeverity.error.name ||
        string == '"${LintSeverity.error.name}"') {
      return LintSeverity.error;
    }
    if (string == LintSeverity.warning.name ||
        string == '"${LintSeverity.warning.name}"') {
      return LintSeverity.warning;
    }
    if (string == LintSeverity.info.name ||
        string == '"${LintSeverity.info.name}"') {
      return LintSeverity.info;
    }
    throw InvalidSeverityException(string);
  }

  // used to colorize CLI output
  String get ansi {
    final ansi = Ansi(true);
    switch (this) {
      case LintSeverity.info:
        return name;
      case LintSeverity.warning:
        return '${ansi.bold}${ansi.yellow}$name${ansi.none}';
      case LintSeverity.error:
        return '${ansi.bold}${ansi.red}$name${ansi.none}';
      default:
        throw UnimplementedError();
    }
  }
}
