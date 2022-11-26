import 'dart:async';

import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';

final analyzerClientProvider =
    Provider<AnalyzerClient>((ref) => throw UnimplementedError());

abstract class AnalyzerClient {
  const AnalyzerClient();
  List<Uri> get roots;
  Map<AnalyzedFile, Set<LintResult>> get lintResults;
  Future<void> openWorkspace();
  Future<void> handleFileChange(Uri file, String content);
  Future<List<EditResult>> getQuickFixes(Uri file, int offset);
  void handleDeletedFile(Uri file);
  void handleOpenFileChange(Uri file, String content);
  void closeWorkspace();
  Stream<LintNotification> get lints;
  Stream<LogRecord> get logs;
}
