import '../../protocol/models/models.dart';

abstract class LogDelegateBase {
  void sidecarError(Object error, StackTrace stackTrace);

  void sidecarVerboseMessage(String message);

  void sidecarMessage(String message);

  void sidecarLog(String message);

  void analysisResults(String path, List<LintResult> results);

  void analysisResultError(LintResult result, Object err, StackTrace stack);
}
