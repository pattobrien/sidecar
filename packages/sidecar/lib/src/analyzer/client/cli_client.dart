import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';

import '../../protocol/logging/log_record.dart';
import '../../protocol/protocol.dart';
import '../../reports/stdout_reporter.dart';
import '../../services/active_project_service.dart';
import '../../utils/logger/logger.dart';
import '../server/runner/context_providers.dart';
import '../server/runner/runner_providers.dart';
import '../server/runner/sidecar_runner.dart';
import '../starters/starters.dart';
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

  StdoutReporter get reporter => _ref.read(stdoutReportProvider);
  Uri get root => _ref.read(cliDirectoryProvider);

  final _lintController = StreamController<LintNotification>();
  final _logController = StreamController<LogRecord>();

  @override
  Future<void> handleFileChange(Uri file, String content) async {
    // if file = package_config.json file of any runners, then rebuild runner
    // else, send file change to all applicable runners
    final analyzedFile = runner.getAnalyzedFile(file.path);
    if (analyzedFile == null) return;
    final changedFileRequest = FileUpdateEvent.add(analyzedFile, content);
    final request = SidecarRequest.updateFiles([changedFileRequest]);
    await runner.asyncRequest<UpdateFilesResponse>(request);
    reporter.print();
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

  @override
  Future<void> openWorkspace() async {
    reporter.init(root);
    final activeContext = activeProjectService.getActivePackageFromUri(root);

    if (activeContext == null) {
      logger.severe('invalid Sidecar directory.');
      return;
    }
    _ref.read(runnerActiveContextsProvider.notifier).update = [activeContext];

    final subscription = runner.lints.listen(reporter.handleLintNotification);
    _subscriptions.add(subscription);
    await runner.initialize();
    const request = SetContextCollectionRequest(null);
    await runner.asyncRequest<SetWorkspaceResponse>(request);
    reporter.print();
  }

  final List<StreamSubscription> _subscriptions = [];
  final Map<AnalyzedFile, Set<LintResult>> _results = {};

  @override
  void closeWorkspace() {
    reporter.print();
    _logController.close();
    _lintController.close();
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
