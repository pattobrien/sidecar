import '../../analyzer/results/analysis_result.dart';
import '../../cli/reports/file_stats.dart';

abstract class LogDelegateBase {
  void generateReport(Iterable<FileStats> reports);

  void sidecarError(
    Object error,
    StackTrace stackTrace,
  );

  void sidecarVerboseMessage(
    String message,
  );

  void sidecarMessage(
    String message,
  );

  void pluginInitializationFail(
    Object err,
    StackTrace stackTrace,
  );

  void analysisResults(String path, List<LintResult> results);

  void pluginRestart();

  void analysisResultError(
    LintResult result,
    Object err,
    StackTrace stackTrace,
  );
}

// extension LintRuleTypeX on LintRuleType {
//   String get coloredNamedd {
//     // final ansi = AnsiPen();

//     switch (this) {
//       case LintRuleType.info:
//         // ansi.white(bold: true);
//         // return ansi(name);
//         return '   ${logger.ansi.blue}$name${logger.ansi.none}';
//       case LintRuleType.warning:
//         // ansi.yellow();
//         // return ansi(name);
//         return '${logger.ansi.yellow}$name${logger.ansi.none}';
//       case LintRuleType.error:
//         // ansi.red();
//         // return ansi(name);
//         return '  ${logger.ansi.red}$name${logger.ansi.none}';
//     }
//   }
// }
