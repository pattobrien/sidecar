import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../protocol/logging/log_record.dart';
import '../../../protocol/protocol.dart';
import '../../../utils/printer/lint_printer.dart';
import '../../context/active_context.dart';
import '../../context/context.dart';
import '../../starters/server_starter.dart';
import 'context_providers.dart';
import 'message_providers.dart';

class SidecarRunner {
  SidecarRunner(
    this._ref, {
    required this.context,
  }) : receivePort = ReceivePort('runner');

  final Ref _ref;
  final ActiveContext context;
  List<AnalysisContext> get allContexts =>
      [context.context, ...context.allRoots];
  final ReceivePort receivePort;

  AnalyzedFile? getAnalyzedFileForPath(String path) => allContexts
      .firstWhereOrNull(
          (ctx) => ctx.typedAnalyzedFiles().any((file) => file.path == path))
      ?.typedAnalyzedFiles()
      .firstWhere((file) => file.path == path);

  late final SendPort sendPort;

  ResourceProvider get resourceProvider => _ref.read(runnerResourceProvider);

  final _controller = StreamController<Object>();
  Stream<Object> get _stream => _controller.stream;

  Stream<ResponseMessage> get _responses =>
      _ref.read(analyzerResponseStreamProvider(this).stream);

  Stream<SidecarNotification> get notifications =>
      _ref.read(analyzerNotificationStreamProvider(this).stream);

  Stream<LogRecord> get logs =>
      _ref.read(analyzerLogStreamProvider(this).stream);

  Stream<LintNotification> get lints => notifications
      .where((e) => e is LintNotification)
      .map((e) => e as LintNotification);

  /// Starts the plugin and sends the necessary requests for initializing it.
  Future<void> initialize() async {
    print('initializing...');
    _initStream();

    await serverSideStarter(
      sendPort: receivePort.sendPort,
      root: context.activeRoot.root.toUri(),
    );

    notifications.listen((event) => event.map(
          initComplete: (_) => handleInitialization(),
          lint: (_) => null,
        ));

    await _initializationCompleter.future;
    await requestSetActiveRoot();
    // await _requestSetContext();
  }

  void _initStream() {
    receivePort.listen(
      (dynamic m) {
        if (m == null) return;
        if (m is SendPort) {
          sendPort = m;
        } else if (m is String) {
          try {
            // print('${DateTime.now().toIso8601String()}: $m');
            final jsonObject = jsonDecode(m) as Map<String, dynamic>;
            _controller.add(jsonObject);
          } catch (e) {
            print('something went wrong: $e: $m');
          }
        } else {
          print('got unexpected type: ${m.runtimeType}');
          _controller.add(m as Object);
        }
      },
      onError: (dynamic e) => _controller.addError(e as Object),
      onDone: _controller.close,
    );
  }

  void handleInitialization() {
    print('initialization completed\n');
    _initializationCompleter.complete();
  }

  final _initializationCompleter = Completer<void>();

  AnalysisContext? getContextForPath(String path) {
    return allContexts
        .firstWhereOrNull((element) => element.contextRoot.isAnalyzed(path));
  }

  Future<List<LintResult>> requestLintsForFile(AnalyzedFile file) async {
    final contents = resourceProvider.getFile(file.path).readAsStringSync();
    final fileUpdateEvent = FileUpdateEvent.add(file, contents);
    final request = FileUpdateRequest([fileUpdateEvent]);
    // print(request.toJson());
    unawaited(asyncRequest<UpdateFilesResponse>(request));
    final lintNotification =
        await lints.firstWhere((element) => element.file == file);
    // print('received lints: ${lintNotification.toJson()}');
    return lintNotification.lints;
  }

  Future<void> requestSetActiveRoot() async {
    // print('_requestSetActiveRoot');
    final mainContextRoot = context.activeRoot.root.toUri();
    final request = SetActiveRootRequest(mainContextRoot);
    await asyncRequest(request);
    // print('_requestSetActiveRoot completed');
  }

  Future<ContextCollectionResponse> requestSetContext() async {
    // print('_requestSetContext');
    final mainContext = context;
    final allContextRootPaths = <String>[
      mainContext.activeRoot.root.path,
      ...mainContext.allRoots.map((e) => e.contextRoot.root.path),
    ];
    final request = SetContextCollectionRequest(
        mainRoot: mainContext.activeRoot.root.path, roots: allContextRootPaths);
    final response = await asyncRequest<ContextCollectionResponse>(request);
    // print('_requestSetContext completed');
    return response;
  }

  Future<T> asyncRequest<T extends SidecarResponse>(
    SidecarRequest request,
  ) async {
    final id = const Uuid().v4();
    final wrappedRequest = SidecarMessage.request(request: request, id: id);
    final json = wrappedRequest.toJson();
    final encoded = jsonEncode(json);
    // print('request: $encoded');
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

final analyzerStreamProvider = StreamProvider.family<Object, SidecarRunner>(
  (ref, runner) async* {
    final stream = runner._stream;
    await for (final event in stream) {
      yield event;
    }
  },
  name: 'serverChannelStreamProvider',
);
