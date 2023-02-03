import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';

import '../protocol/protocol.dart';
import '../reports/stdout_reporter.dart';
import '../server/server_providers.dart';
import '../server/sidecar_server.dart';
import '../server/starters/cli_starter.dart';
import '../services/active_project_service.dart';
import '../utils/logger/logger.dart';
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
  Future<UpdateFilesResponse?> handleFileChange(
      Uri file, String content) async {
    // if file = package_config.json file of any runners, then rebuild runner
    // else, send file change to all applicable runners
    final analyzedFile = runner.getAnalyzedFile(file.toFilePath());
    if (analyzedFile == null) return null;
    final changedFileRequest = FileUpdateEvent.add(analyzedFile, content);
    final request = SidecarRequest.updateFiles([changedFileRequest]);
    final response = await runner.asyncRequest<UpdateFilesResponse>(request);
    reporter.print();
    return response;
  }

  @override
  void handleOpenFileChange(Uri file, String content) {
    throw UnimplementedError('cli client cannot read open files.');
  }

  @override
  void handleDeletedFile(Uri file) {
    // TODO: implement handleDeletedFile
  }

  SidecarServer get runner => _ref.read(runnersProvider).single;

  @override
  Future<void> openWorkspace() async {
    reporter.init(root);
    final activeContext = activeProjectService.getActivePackageFromUri(root);

    if (activeContext == null) {
      // logger.severe('invalid Sidecar directory.');
      // print('invalid sidecar directory');
      // throw StateError('invalid Sidecar directory');
      return;
    }
    _ref.read(runnerActiveContextProvider.notifier).state = [activeContext];

    final subscription = runner.lints.listen(reporter.handleLintNotification);
    _subscriptions.add(subscription);
    await runner.initialize([root]);
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

  @override
  Future<List<EditResult>> getQuickFixes(String file, int offset) async {
    final analyzedFile = runner.getAnalyzedFile(file);
    if (analyzedFile == null) {
      final contexts = runner.allContexts.map((e) => e.contextRoot.root.path);
      throw StateError(
          'file doesnt have an analysis context; file: $file || contexts: $contexts');
    }
    final request = QuickFixRequest(file: analyzedFile, offset: offset);
    final response = await runner.asyncRequest<QuickFixResponse>(request);
    return response.results
        .map((e) => e.edits)
        .expand((element) => element)
        .toList();
  }
}

final cliClientProvider = Provider<AnalyzerClient>((ref) {
  final activeProjectService = ref.watch(activeProjectServiceProvider);
  return CliClient(ref, activeProjectService: activeProjectService);
});
