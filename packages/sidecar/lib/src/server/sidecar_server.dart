import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../protocol/protocol.dart';
import '../services/active_project_service.dart';
import '../services/entrypoint_builder_service.dart';
import '../utils/analysis_context_utilities.dart';
import '../utils/uri_ext.dart';
import 'server_providers.dart';
import 'starters/server_starter.dart';

class SidecarServer {
  SidecarServer(
    this._ref, {
    required this.activePackage,
  });

  final Ref _ref;

  final ProviderContainer _runnerContainer = ProviderContainer();

  final ActivePackage activePackage;

  final ReceivePort receivePort = ReceivePort('runner');

  List<AnalysisContext> get allContexts =>
      _runnerContainer.read(_runnerContextsProvider);

  AnalysisContext? contextForFile(AnalyzedFile file) =>
      _runnerContainer.read(_contextForFileProvider(file));

  void _setContexts([List<Uri>? roots]) {
    if (roots == null) {
      final packagePaths = [activePackage.root.pathNoTrailingSlash];
      final contexts = AnalysisContextCollection(includedPaths: packagePaths)
          .contexts
          .where((context) => activePackage.packageConfig.packages
              .any((dep) => dep.root == context.contextRoot.root.toUri()))
          .toList();
      _runnerContainer.read(_runnerContextsProvider.notifier).state = contexts;
      // allContexts.addAll(contexts);
    } else {
      final contexts = AnalysisContextCollection(
              includedPaths: roots.map((e) => e.pathNoTrailingSlash).toList())
          .contexts
          .where((context) => activePackage.packageConfig.packages
              .any((dep) => dep.root == context.contextRoot.root.toUri()))
          .toList();
      _runnerContainer.read(_runnerContextsProvider.notifier).state = contexts;
      // allContexts.addAll(contexts);
    }
  }

  AnalyzedFile? getAnalyzedFile(String path) =>
      _runnerContainer.read(_fileForPathProvider(path));

  late final SendPort sendPort;

  final _controller = StreamController<Object>();
  Stream<Object> get _stream => _controller.stream;

  Stream<ResponseMessage> get _responses =>
      _ref.read(_analyzerResponseStreamProvider(this).stream);

  Stream<SidecarNotification> get notifications =>
      _ref.read(_analyzerNotificationStreamProvider(this).stream);

  Stream<LogRecord> get logs =>
      _ref.read(_analyzerLogStreamProvider(this).stream);

  Stream<LintNotification> get lints => notifications
      .where((e) => e is LintNotification)
      .map((e) => e as LintNotification);

  /// Starts the server isolate and sends the necessary requests for initializing it.
  Future<void> initialize([List<Uri>? roots]) async {
    _setContexts(roots);
    _initStream();
    final isolateBuilder = _ref.read(isolateBuilderServiceProvider);
    final activeProjectService = _ref.read(activeProjectServiceProvider);
    final resourceProvider = _ref.read(serverResourceProvider);

    final packageRoot = activePackage.root;
    final config = activeProjectService.getPackageConfig(packageRoot);
    final pluginRoot = activeProjectService.getSidecarDependencyUri(config);
    final deps = activeProjectService.getSidecarDependencies(config);

    isolateBuilder.setupPluginSourceFiles(packageRoot, pluginRoot!);
    isolateBuilder.setupBootstrapper(packageRoot, deps);

    await analyzerIsolateStarter(
        resourceProvider: resourceProvider,
        sendPort: receivePort.sendPort,
        root: activePackage.root);

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
    assert(msg != null && msg is T, 'Response was an unexpected type');
    if (msg == null || msg is! T) throw UnimplementedError();
    return msg;
  }
}

final analyzerStreamProvider = StreamProvider.family<Object, SidecarServer>(
  (ref, runner) async* {
    final stream = runner._stream;
    await for (final event in stream) {
      yield event;
    }
  },
  name: 'serverChannelStreamProvider',
);

final _runnerContextsProvider =
    StateProvider<List<AnalysisContext>>((ref) => []);

final _fileForPathProvider =
    Provider.family<AnalyzedFile?, String>((ref, path) {
  final context = ref.watch(_runnerContextsProvider).contextForPath(path);
  if (context == null) return null;
  return AnalyzedFile(Uri.parse(path),
      contextRoot: context.contextRoot.root.toUri());
});

final _contextForFileProvider = Provider.family<AnalysisContext?, AnalyzedFile>(
  (ref, file) {
    final contexts = ref.watch(_runnerContextsProvider);
    return contexts.contextForRoot(file.contextRoot);
  },
);

final _analyzerMessageStreamProvider =
    StreamProvider.family<SidecarMessage, SidecarServer>((ref, runner) {
  final stream = ref.watch(analyzerStreamProvider(runner).stream);
  return stream.where((event) => event is Map<String, dynamic>).map((event) {
    final map = event as Map<String, dynamic>;
    return SidecarMessage.fromJson(map);
  });
});

final _analyzerNotificationStreamProvider =
    StreamProvider.family<SidecarNotification, SidecarServer>(
  (ref, runner) => ref
      .watch(_analyzerMessageStreamProvider(runner).stream)
      .map((event) => event)
      .where((event) => event is NotificationMessage)
      .map((event) => (event as NotificationMessage).notification),
  name: 'analyzerNotificationStreamProvider',
);

final _analyzerLogStreamProvider =
    StreamProvider.family<LogRecord, SidecarServer>(
  (ref, runner) => ref
      .watch(_analyzerMessageStreamProvider(runner).stream)
      .where((event) => event is LogMessage)
      .map((event) => (event as LogMessage).record),
  name: 'analyzerLogStreamProvider',
);

final _analyzerResponseStreamProvider =
    StreamProvider.family<ResponseMessage, SidecarServer>(
  (ref, runner) => ref
      .watch(_analyzerMessageStreamProvider(runner).stream)
      .where((event) => event is ResponseMessage)
      .map((event) => event as ResponseMessage),
  name: 'analyzerResponseStreamProvider',
);
