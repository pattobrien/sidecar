import 'package:riverpod/riverpod.dart';

import '../../analyzed_file/analyzed_file.dart';
import '../../reports/file_report_notifier.dart';
import '../../reports/file_stats.dart';

final fileReportProvider = StateNotifierProvider.family<FileReportNotifier,
    AsyncValue<FileStats>, AnalyzedFile>(
  (ref, arg) {
    return FileReportNotifier(ref, arg);
  },
  dependencies: [],
);
