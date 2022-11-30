import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../protocol/models/log_record.dart';
import '../../../protocol/protocol.dart';
import '../../../services/active_project_service.dart';
import '../../../services/entrypoint_builder_service.dart';
import '../../../utils/analysis_context_utilities.dart';
import '../../../utils/uri_ext.dart';
import '../../starters/server_starter.dart';
import 'context_providers.dart';
import 'message_providers.dart';

class SidecarRunner {
  SidecarRunner(
    this._ref, {
    required this.activePackage,
  });

  final Ref _ref;
  final ProviderContainer _runnerContainer = ProviderContainer();
  final ActivePackage activePackage;
  List<AnalysisContext> get allContexts =>
      _runnerContainer.read(_runnerContextsProvider);
  AnalysisContext? contextForFile(AnalyzedFile file) =>
      _runnerContainer.read(_contextForFileProvider(file));
  final ReceivePort receivePort = ReceivePort('runner');

  void _setContexts([List<Uri>? roots]) {
    if (roots == null) {
      final packagePaths = [activePackage.packageRoot.root.pathNoTrailingSlash];
      final contexts = AnalysisContextCollection(includedPaths: packagePaths)
          .contexts
          .where((context) =>
              activePackage.packageConfig?.packages
                  .any((dep) => dep.root == context.contextRoot.root.toUri()) ??
              false)
          .toList();
      _runnerContainer.read(_runnerContextsProvider.notifier).state = contexts;
      // allContexts.addAll(contexts);
    } else {
      final contexts = AnalysisContextCollection(
              includedPaths: roots.map((e) => e.pathNoTrailingSlash).toList())
          .contexts
          .where((context) =>
              activePackage.packageConfig?.packages
                  .any((dep) => dep.root == context.contextRoot.root.toUri()) ??
              false)
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
      _ref.read(analyzerResponseStreamProvider(this).stream);

  Stream<SidecarNotification> get notifications =>
      _ref.read(analyzerNotificationStreamProvider(this).stream);

  Stream<LogRecord> get logs =>
      _ref.read(analyzerLogStreamProvider(this).stream);

  Stream<LintNotification> get lints => notifications
      .where((e) => e is LintNotification)
      .map((e) => e as LintNotification);

  /// Starts the server isolate and sends the necessary requests for initializing it.
  Future<void> initialize([List<Uri>? roots]) async {
    _setContexts(roots);
    _initStream();
    final isolateBuilder = _ref.read(isolateBuilderServiceProvider);
    final activeProjectService = _ref.read(activeProjectServiceProvider);
    final resourceProvider = _ref.read(runnerResourceProvider);

    final packageRoot = activePackage.packageRoot.root;
    final pluginRoot = activePackage.sidecarPluginPackage;
    final config = activeProjectService.getPackageConfig(packageRoot);
    final deps = activeProjectService.getSidecarDependencies(config);

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
    assert(msg != null && msg is T, 'Response was an unexpected type');
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
