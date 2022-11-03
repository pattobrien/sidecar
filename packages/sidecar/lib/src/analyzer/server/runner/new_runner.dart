import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/file_system/file_system.dart';
import 'package:riverpod/riverpod.dart';

import '../../../protocol/protocol.dart';
import '../../../services/services.dart';
import '../../context/active_context.dart';
import '../../results/results.dart';
import '../../starters/server_starter.dart';
import 'notification_providers.dart';

final newRunnerProvider = FutureProvider<List<NewSidecarRunner>>(
  (ref) async {
    final activePrimaryContexts =
        ref.watch(activePrimaryContextsForRunnerProvider);
    print('newRunnerProvider: ${activePrimaryContexts.length}');
    final runners =
        await Future.wait(activePrimaryContexts.map((context) async {
      final runner = NewSidecarRunner(ref, context);
      await runner.initialize();
      print('init');
      return runner;
    }));

    print('got runners');
    return runners;
  },
  name: 'newRunnerProvider',
);

final newRunnerForContextProvider =
    FutureProvider.family<NewSidecarRunner, ActiveContext>(
  (ref, context) async {
    final runners = await ref.watch(newRunnerProvider.future);
    return runners.firstWhere((element) => element.activeContext == context);
  },
  name: 'newRunnerProvider',
);

class NewSidecarRunner {
  NewSidecarRunner(
    this.ref,
    this.activeContext,
  );

  final Ref ref;
  final ActiveContext activeContext;

  final completed = Completer<void>();
  final receivePort = ReceivePort('runner');
  late final SendPort sendPort;

  bool _closed = false;

  ActiveProjectService get activeProjectService =>
      ref.read(activeProjectServiceProvider);

  ResourceProvider get resourceProvider =>
      ref.read(runnerResourceProviderProvider);

  Future<void> initializeIsolate() async {
    await serverSideStarter(
        sendPort: receivePort.sendPort,
        root: activeContext.activeRoot.root.toUri());
  }

  Stream<Object> get stream => ref.read(analyzerStreamProvider(this).stream);

  Stream<ResponseWrapper> get _responses =>
      ref.read(analyzerResponseStreamProvider(this).stream);

  Stream<NotificationBase> get _notifications => ref
      .read(analyzerNotificationStreamProvider(this).stream)
      .map((event) => event.base);

  Stream<InitializationComplete> get _initizationNotification => _notifications
      .where((e) => e.method == kInitializationCompleteMethod)
      .map((event) => event as InitializationComplete);

  Stream<AnalysisResult> get _lintResultsNotification => _notifications
      .where((e) => e is LintResult)
      .map((event) => event as LintResult);

  Stream<AnalysisResult> get _assistResultsNotification => _notifications
      .where((e) => e is AssistResult)
      .map((event) => event as AssistResult);

  /// Starts the plugin and sends the necessary requests for initializing it.
  Future<void> initialize() async {
    print('initializing...');
    await initializeIsolate();

    _initizationNotification.listen((_) {
      print('initialization completed');
      _initializationCompleter.complete();
    });

    _lintResultsNotification
        .listen((event) => print('ANALYSISRESULT: ${event.toString()}'));

    // _reloader.listen((event) {
    //   // TODO: replace set context with a simple update, based on the [event]
    //   // and the updated contents
    //   _requestSetContext();
    // });

    stream.listen((e) {
      if (e is SendPort) {
        sendPort = e;
      }
      print('received: ${e}');
      if (e is RequestWrapper) {
        print('requestwrapper: ${e.base.toJson()}');
      }
    });
    _responses.listen((event) => print(event.toString()));

    await _initializationCompleter.future;
    await _requestSetContext();
  }

  final _initializationCompleter = Completer<void>();

  // Future<List<LintResult>> requestLintsForFile(String path) async {
  //   //
  //   final content = resourceProvider.getFile(path).readAsStringSync();
  //   final req =
  //       plugin.AnalysisUpdateContentParams({path: AddContentOverlay(content)});
  //   sendRequest(req.toRequest(_uuid.v4()));
  //   // final res = await server.handleAnalysisUpdateContent(req);

  //   // final notification = await _notifications.firstWhere(
  //   //     (notification) => notification.event == kAnalysisResultsMethod);
  //   final analysisErrors =
  //       plugin.AnalysisErrorsParams.fromNotification(notification);
  //   return analysisErrors.errors;
  // }

  Future<void> _requestSetContext() async {
    // print('setting context');
    final mainContext = activeContext;
    final contexts =
        activeProjectService.getActiveDependencies(activeContext, []);
    final allContexts = [mainContext, ...contexts];
    final roots = allContexts.map((e) => e.activeRoot.root.path).toList();
    await asyncRequest(SetContextCollectionRequest(roots));
    print('setting context compelete');
  }

  void sendRequest(RequestWrapper request) => sendPort.send(request.toJson());

  Future<ResponseWrapper> asyncRequest(RequestBase baseRequest) {
    final request = baseRequest.toSidecarRequest();
    sendRequest(request);
    return _responses.firstWhere((response) => response.id == request.id);
  }

  /// Stop the command runner, sending a [plugin.PluginShutdownParams] request in the process.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    //TODO: this should be awaited
    // sendRequest(plugin.PluginShutdownParams().toRequest(_uuid.v4()));
  }
}
