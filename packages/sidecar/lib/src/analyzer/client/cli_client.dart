import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';
import '../../reports/stdout_report.dart';
import '../../services/active_project_service.dart';
import '../../utils/file_paths.dart';
import '../server/runner/context_providers.dart';
import '../server/runner/runner_providers.dart';
import '../server/runner/sidecar_runner.dart';
import 'client.dart';

class CliClient extends AnalyzerClient {
  CliClient(
    this._ref, {
    required this.activeProjectService,
  });

  final ActiveProjectService activeProjectService;
  final Ref _ref;

  @override
  Stream<LintNotification> get lints => _lintController.stream;

  @override
  Stream<LogRecord> get logs => _logController.stream.asBroadcastStream();

  StdoutReport get reporter => _ref.read(stdoutReportProvider);

  final _lintController = StreamController<LintNotification>();
  final _logController = StreamController<LogRecord>();

  @override
  void handleFileChange(Uri file, String content) {
    // if file = package_config.json file of any runners, then rebuild runner
    // else, send file change to all applicable runners
  }

  @override
  void handleOpenFileChange(Uri file, String content) {
    throw UnimplementedError('cli client cannot read open files.');
  }

  @override
  void handleDeletedFile(Uri file) {
    // TODO: implement handleDeletedFile
  }

  SidecarRunner get runner => _ref.read(runnersProvider).single;

  late IOSink logFileSink;

  @override
  Future<void> openWorkspace() async {
    final directory = Directory.current;
    reporter.init(directory.uri);
    final path = directory.path;
    final activeContext =
        activeProjectService.getActivePackageFromUri(directory.uri);

    final logFile = File.fromUri(
        directory.uri.resolve(join(kDartTool, 'logs', 'session.txt')))
      ..createSync(recursive: true);
    logFileSink = logFile.openWrite(mode: FileMode.append);
    final logSub = logs.listen((log) => logFileSink.write(log.prettified()));
    _subscriptions.add(logSub);
    if (activeContext == null) {
      throw StateError('Invalid Sidecar directory: $path');
    }
    _ref.read(runnerActiveContextsProvider.notifier).update = [activeContext];

    final subscription = runner.lints.listen(reporter.handleLintNotification);
    _subscriptions.add(subscription);
    await runner.initialize();
    const request = SetContextCollectionRequest(null);
    await runner.asyncRequest<SetWorkspaceResponse>(request);
  }

  final List<StreamSubscription> _subscriptions = [];
  final Map<AnalyzedFile, Set<LintResult>> _results = {};

  @override
  void closeWorkspace() {
    reporter.save();
    _logController.close();
    _lintController.close();
    logFileSink.close();
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
  }

  @override
  List<Uri> get roots => [Directory.current.uri];

  @override
  Map<AnalyzedFile, Set<LintResult>> get lintResults => _results;
}

final cliClientProvider = Provider<AnalyzerClient>((ref) {
  final activeProjectService = ref.watch(activeProjectServiceProvider);
  return CliClient(ref, activeProjectService: activeProjectService);
});
