import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../protocol/logging/log_record.dart';
import '../../../protocol/protocol.dart';
import '../../../utils/duration_ext.dart';
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

  AnalyzedFile? getAnalyzedFile(String path) {
    final context = allContexts
        .firstWhereOrNull((context) => context.contextRoot.isAnalyzed(path));
    if (context == null) return null;
    return AnalyzedFile(Uri.parse(path),
        contextRoot: context.contextRoot.root.toUri());
  }

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
          initComplete: (_) => handleStartupNotification(),
          lint: (_) => null,
        ));

    await _initializationCompleter.future;
    await requestSetActiveRoot();
  }

  void _initStream() {
    receivePort.listen(
      (dynamic m) {
        if (m == null) return;
        assert(m is SendPort || m is String,
            'unexpected type ${m.runtimeType} $m');
        if (m is SendPort) {
          sendPort = m;
        } else if (m is String) {
          final jsonObject = jsonDecode(m) as Map<String, dynamic>;
          _controller.add(jsonObject);
        }
      },
      onError: (dynamic e) => _controller.addError(e as Object),
      onDone: _controller.close,
    );
  }

  void handleStartupNotification() {
    print('isolate startup completed\n');
    _initializationCompleter.complete();
  }

  final _initializationCompleter = Completer<void>();

  AnalysisContext? getContextForPath(String path) {
    return allContexts
        .firstWhereOrNull((element) => element.contextRoot.isAnalyzed(path));
  }

  Future<T?> asyncCancelableRequest<T extends SidecarResponse>(
    SidecarRequest request,
  ) async {
    final id = const Uuid().v4();
    final wrappedRequest = SidecarMessage.request(request: request, id: id);
    final json = wrappedRequest.toJson();
    final encoded = jsonEncode(json);
    // print('request: $encoded');
    sendPort.send(encoded);
    final cancelableResponse = CancelableOperation<ResponseMessage>.fromFuture(
      _responses.firstWhere((resp) => resp.id == id),
      onCancel: () => null,
    );
    final response = await cancelableResponse.valueOrCancellation();
    final parsedMessage = response
        ?.mapOrNull(
          response: (response) => response,
          error: (error) => throw UnimplementedError(),
        )
        ?.response;
    if (parsedMessage is! T) throw UnimplementedError();
    return parsedMessage;
  }

  Future<UpdateFilesResponse?> requestLintsForFile(
    AnalyzedFile file,
  ) async {
    final watch = Stopwatch()..start();

    print('file reload 1: ${watch.elapsed.prettified()}');
    final contents = resourceProvider.getFile(file.path).readAsStringSync();
    final fileUpdateEvent = FileUpdateEvent.add(file, contents);
    final request = FileUpdateRequest([fileUpdateEvent]);
    final id = const Uuid().v4();
    final wrappedRequest = SidecarMessage.request(request: request, id: id);
    final json = wrappedRequest.toJson();
    final encoded = jsonEncode(json);
    // print('request: $encoded');
    sendPort.send(encoded);
    final sub = lints.listen((event) {
      if (event.file.path == file.path) {
        print(
            'LINT RECEIVED for ${file.relativePath} in ${watch.elapsed.prettified()}');
      }
    });

    // final responseCompleter = Completer<SidecarMessage>();
    // final conditionCompleter = Completer<void>();
    // await completer?.call().then((value) async {
    //   conditionCompleter.complete();
    // });
    final response = await _responses.firstWhere((resp) => resp.id == id);
    await sub.cancel();
    // .then(responseCompleter.complete);
    // final response = await responseCompleter.future;
    final parsedMessage = response
        .mapOrNull(
          response: (response) => response,
          error: (error) => throw UnimplementedError(),
        )
        ?.response;
    if (parsedMessage == null) throw UnimplementedError();
    if (parsedMessage is! UpdateFilesResponse) throw UnimplementedError();
    // return conditionCompleter.isCompleted ? null : parsedMessage;
    print('file reload 3: ${watch.elapsed.prettified()}');
    return parsedMessage;
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
