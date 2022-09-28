import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:cli_util/cli_logging.dart';

final logger = Logger.standard();

final logDelegateProvider =
    Provider<LogDelegateBase>((ref) => throw UnimplementedError());

abstract class LogDelegateBase {
  void sidecarError(
    Object error,
    StackTrace stackTrace,
  );

  // void sendLints() {}

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

  void lintMessage(
    AnalysisResult result,
    String message,
  );

  void analysisResult(
    AnalysisResult result,
  );

  void editMessage(
    CodeEdit edit,
    String message,
  );

  void pluginRestart();

  void lintError(
    LintRule lint,
    Object err,
    String stackTrace,
  );
}

extension LintRuleTypeX on LintRuleType {
  String get coloredNamedd {
    // final ansi = AnsiPen();

    switch (this) {
      case LintRuleType.info:
        // ansi.white(bold: true);
        // return ansi(name);
        return '   ${logger.ansi.blue}$name${logger.ansi.none}';
      case LintRuleType.warning:
        // ansi.yellow();
        // return ansi(name);
        return '${logger.ansi.yellow}$name${logger.ansi.none}';
      case LintRuleType.error:
        // ansi.red();
        // return ansi(name);
        return '  ${logger.ansi.red}$name${logger.ansi.none}';
    }
  }
}
