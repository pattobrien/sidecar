import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/file_system/file_system.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../protocol/protocol.dart';
import '../../context/active_context.dart';
import '../../starters/server_starter.dart';
import 'context_providers.dart';
import 'message_providers.dart';

class SidecarRunner {
  SidecarRunner(
    this._ref, {
    required this.context,
    required this.contextRoots,
  }) : receivePort = ReceivePort('runner');

  final Ref _ref;
  final ActiveContext context;
  final List<String> contextRoots;
  final ReceivePort receivePort;

  late final SendPort sendPort;

  ResourceProvider get resourceProvider => _ref.read(runnerResourceProvider);

  Stream<Object> get stream => _ref.read(analyzerStreamProvider(this).stream);

  Stream<ResponseMessage> get _responses =>
      _ref.read(analyzerResponseStreamProvider(this).stream);

  Stream<SidecarNotification> get _notifications =>
      _ref.read(analyzerNotificationStreamProvider(this).stream);

  Stream<LintNotification> get _lints => _notifications
      .where((e) => e is LintNotification)
      .map((e) => e as LintNotification);

  /// Starts the plugin and sends the necessary requests for initializing it.
  Future<void> initialize() async {
    print('initializing...');

    await serverSideStarter(
      sendPort: receivePort.sendPort,
      root: context.activeRoot.root.toUri(),
    );

    _notifications.listen((event) => event.mapOrNull(
          initComplete: (_) => handleInitialization(),
        ));

    // _lintResultsNotification
    //     .listen((event) => print('ANALYSISRESULT: ${event.toString()}'));

    // _reloader.listen((event) {
    //   // TODO: replace set context with a simple update, based on the [event]
    //   // and the updated contents
    //   _requestSetContext();
    // });

    await _initializationCompleter.future;
    await _requestSetContext();
  }

  void handleInitialization() {
    print('initialization completed');
    _initializationCompleter.complete();
  }

  final _initializationCompleter = Completer<void>();

  Future<List<LintResult>> requestLintsForFile(String path) async {
    final contents = resourceProvider.getFile(path).readAsStringSync();
    final fileUpdateEvent = FileUpdateEvent.add(path, contents);
    final request = FileUpdateRequest([fileUpdateEvent]);
    final response = await asyncRequest<UpdateFilesResponse>(request);
    final lintNotification =
        await _lints.firstWhere((element) => element.path == path);
    return lintNotification.lints;
  }

  Future<void> _requestSetContext() async {
    final mainContext = context;
    final allContexts = [mainContext.activeRoot.root.path, ...contextRoots];
    final request = SetContextCollectionRequest(
        mainRoot: mainContext.activeRoot.root.path, roots: allContexts);
    await asyncRequest(request);
  }

  Future<T> asyncRequest<T extends SidecarResponse>(
      SidecarRequest request) async {
    final id = const Uuid().v4();
    final wrappedRequest = SidecarMessage.request(request: request, id: id);
    final json = wrappedRequest.toJson();
    final encoded = jsonEncode(json);
    sendPort.send(encoded);
    final response = await _responses.firstWhere((resp) => resp.id == id);
    final parsedMessage = response
        .mapOrNull(
          response: (response) => response,
          error: (error) => throw UnimplementedError(),
        )
        ?.response;
    if (parsedMessage == null) throw UnimplementedError();
    if (parsedMessage is! T) throw UnimplementedError();
    return parsedMessage;
  }

  /// Stop the command runner, sending a [plugin.PluginShutdownParams] request in the process.
  Future<void> close() async {
    // if (_closed) return;
    // _closed = true;
    //TODO: this should be awaited
    // sendRequest(plugin.PluginShutdownParams().toRequest(_uuid.v4()));
  }
}
