import 'package:sidecar/sidecar.dart';

import 'log_delegate_base.dart';

class EmptyDelegate implements LogDelegateBase {
  const EmptyDelegate();

  @override
  void editMessage(CodeEdit edit, String message) {
    // do nothing
  }

  @override
  void lintError(LintRule lint, Object err, String stackTrace) {
    // do nothing
  }

  @override
  void lintMessage(DetectedLint lint, String message) {
    // do nothing
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    // do nothing
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    // do nothing
  }

  @override
  void sidecarVerboseMessage(String message) {
    // do nothing
  }

  @override
  void pluginRestart() {
    // TODO: implement pluginRestart
  }

  @override
  void sidecarMessage(String message) {
    // TODO: implement sidecarMessage
  }

  @override
  void analysisResult(AnalysisResult result) {
    // TODO: implement analysisResultMessage
  }
}
