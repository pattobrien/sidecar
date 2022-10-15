import '../../analyzer/results/analysis_result.dart';
import '../../cli/reports/file_stats.dart';
import 'log_delegate_base.dart';

class EmptyDelegate implements LogDelegateBase {
  const EmptyDelegate();

  @override
  void analysisResultError(
      AnalysisResult result, Object err, StackTrace stackTrace) {
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
    // do nothing
  }

  @override
  void sidecarMessage(String message) {
    // do nothing
  }

  @override
  void analysisResults(String path, List<AnalysisResult> results) {
    // do nothing
  }

  @override
  void generateReport(Iterable<FileStats> reports) {
    // TODO: implement generateReport
  }
}
