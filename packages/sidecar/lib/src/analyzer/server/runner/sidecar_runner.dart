import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../protocol/logging/log_record.dart';
import '../../../protocol/protocol.dart';
import '../../../services/active_project_service.dart';
import '../../../services/isolate_builder_service.dart';
import '../../starters/server_starter.dart';
import 'context_providers.dart';
import 'message_providers.dart';

class SidecarRunner {
  SidecarRunner(
    this._ref, {
    required this.activePackage,
  })  : receivePort = ReceivePort('runner'),
        allContexts = [];

  final Ref _ref;
  final ActivePackage activePackage;
  final List<AnalysisContext> allContexts;
  final ReceivePort receivePort;

  void _setContexts() {
    final paths = activePackage.packageConfig?.packages
            .map((e) => e.root.path)
            .toList()
            .map((path) {
          if (path.endsWith('/')) {
            return path.substring(0, path.length - 1);
          } else {
            return path;
          }
        }).toList() ??
        [];
    final contexts = AnalysisContextCollection(includedPaths: paths)
        .contexts
        .where((context) =>
            activePackage.packageConfig?.packages
                .any((dep) => dep.root == context.contextRoot.root.toUri()) ??
            false)
        .toList();
    allContexts.addAll(contexts);
  }

  AnalyzedFile? getAnalyzedFile(String path) {
    final context = allContexts
        .firstWhereOrNull((context) => context.contextRoot.isAnalyzed(path));
    if (context == null) return null;
    return AnalyzedFile(Uri.parse(path),
        contextRoot: context.contextRoot.root.toUri());
  }

  late final SendPort sendPort;

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

  /// Starts the server isolate and sends the necessary requests for initializing it.
  Future<void> initialize() async {
    _setContexts();
    _initStream();
    final isolateBuilder = _ref.read(isolateBuilderServiceProvider);
    final activeProjectService = _ref.read(activeProjectServiceProvider);
    final resourceProvider = _ref.read(runnerResourceProvider);

    final packageRoot = activePackage.packageRoot.root;
    final pluginRoot = activePackage.sidecarPluginPackage.root;
    final deps = activeProjectService.getSidecarDependencies(packageRoot);

    isolateBuilder.setupPluginSourceFiles(packageRoot, pluginRoot);
    isolateBuilder.setupBootstrapper(packageRoot, deps);

    await analyzerIsolateStarter(
        resourceProvider: resourceProvider,
        sendPort: receivePort.sendPort,
        root: activePackage.packageRoot.root);

    await notifications.firstWhere((e) => e is InitCompleteNotification);
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

  Future<T> asyncRequest<T extends SidecarResponse>(
    SidecarRequest request,
  ) async {
    final id = const Uuid().v4();
    final wrappedRequest = SidecarMessage.request(request: request, id: id);
    final message = wrappedRequest.toEncodedJson();
    sendPort.send(message);
    final response = await _responses.firstWhere((resp) => resp.id == id);
    final msg = response.mapOrNull(response: (response) => response)?.response;
    assert(msg == null || msg is! T, 'Response was an unexpected type');
    if (msg == null || msg is! T) throw UnimplementedError();
    return msg;
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
