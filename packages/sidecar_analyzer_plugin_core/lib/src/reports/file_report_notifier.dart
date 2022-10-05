import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../context_services/analyzed_file.dart';
import 'file_stats.dart';

class FileReportNotifier extends StateNotifier<AsyncValue<FileStats>> {
  FileReportNotifier(this.ref, this._file) : super(const AsyncValue.loading());

  final Ref ref;
  final AnalyzedFile _file;

  final _stopwatch = Stopwatch();
  late Duration _resolveDuration;
  late Duration _resolveStart;
  late Duration _lintDuration;
  late Duration _lintStart;
  late Duration _annotationsDuration;
  late Duration _annotationsStart;

  void start() {
    _stopwatch.reset();
    _stopwatch.start();
  }

  void recordUnitResolved() =>
      _resolveDuration = _stopwatch.elapsed - _resolveStart;
  void recordUnitStart() => _resolveStart = _stopwatch.elapsed;

  void recordLintsCompleted() =>
      _lintDuration = _stopwatch.elapsed - _lintStart;
  void recordLintsStarted() => _lintStart = _stopwatch.elapsed;

  void recordAnnotationsCompleted() =>
      _annotationsDuration = _stopwatch.elapsed - _annotationsStart;

  void recordAnnotationsStart() => _annotationsStart = _stopwatch.elapsed;

  void complete(List<AnalysisResult> results) {
    state = AsyncValue.data(
      FileStats.initialResolve(
        file: _file,
        timeToComputeAnnotations: _annotationsDuration,
        timeToLint: _lintDuration,
        timeToResolveUnit: _resolveDuration,
        totalTime: _stopwatch.elapsed,
        analysisResults: results,
      ),
    );
    _stopwatch.stop();
  }
}
