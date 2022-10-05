import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../../reports/file_report_notifier.dart';
import '../../reports/file_stats.dart';

// final logger = Logger.standard();

final logDelegateProvider = Provider<LogDelegateBase>(
  (ref) => throw UnimplementedError(),
);

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

  void analysisResults(
    String path,
    List<AnalysisResult> results,
  );

  void pluginRestart();

  void analysisResultError(
    AnalysisResult result,
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
