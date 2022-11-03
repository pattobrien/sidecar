import '../../protocol/models/models.dart';

abstract class LogDelegateBase {
  void sidecarError(Object error, StackTrace stackTrace);

  void sidecarVerboseMessage(String message);

  void sidecarMessage(String message);

  void pluginInitializationFail(Object err, StackTrace stackTrace);

  void analysisResults(String path, List<LintResult> results);

  void pluginRestart();

  void analysisResultError(LintResult result, Object err, StackTrace stack);
}
