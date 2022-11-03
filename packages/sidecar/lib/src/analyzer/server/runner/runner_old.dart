// ignore_for_file: implementation_imports, unnecessary_lambdas

import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../protocol/protocol.dart';
import 'context_providers.dart';

const _uuid = Uuid();

final runnerProvider = Provider<SidecarRunnerOld>(
  (ref) => SidecarRunnerOld(ref),
  name: 'runnerProvider',
);

class SidecarRunnerOld {
  SidecarRunnerOld(this.ref);

  final Ref ref;
  final completed = Completer<void>();

  bool _closed = false;

  io.Directory get root => ref.read(activeRunnerDirectory);

  plugin.DiscoveredServerIsolateChannel get channel =>
      throw UnimplementedError();
  // ref.read(masterServerChannel);

  ResourceProvider get _resourceProvider => ref.read(runnerResourceProvider);

  Stream<plugin.Notification> get _notifications => throw UnimplementedError();
  // ref.read(serverChannelNotificationStreamProvider.stream);

  Stream<plugin.Response> get _responses => throw UnimplementedError();
  // ref.read(serverChannelResponseStreamProvider.stream);

  Stream<plugin.Notification> get _reloader =>
      _notifications.where((e) => e.event == kSidecarHotReloadMethod);

  Stream<plugin.Notification> get _initizationNotification =>
      _notifications.where((e) => e.event == kInitializationCompleteMethod);

  Stream<plugin.AnalysisErrorsParams> get _analysisResultsNotification =>
      _notifications
          .where((e) => e.event == kAnalysisResultsMethod)
          .map((event) => plugin.AnalysisErrorsParams.fromNotification(event));

  // /// Error [Notification]s.
  Stream<plugin.PluginErrorParams> get pluginErrors => _notifications
      .where((e) => e.event == 'plugin.error')
      .map(plugin.PluginErrorParams.fromNotification);

  /// Errors for [plugin.Request]s that failed.
  Stream<plugin.RequestError> get responseErrors =>
      _responses.where((e) => e.error != null).map((e) => e.error!);

  ContextLocator get contextLocator =>
      ContextLocator(resourceProvider: _resourceProvider);

  List<ContextRoot> get allContextRoots =>
      contextLocator.locateRoots(includedPaths: [root.path]);

  List<ContextRoot> get contextRoots => allContextRoots;

  /// Starts the plugin and sends the necessary requests for initializing it.
  Future<void> initialize() async {
    print('initializing...');

    _initizationNotification.listen((event) {
      print('initialization completed');
      _initializationCompleter.complete();
    });

    responseErrors.listen((event) {
      print(event.toJson().toString());
    });

    pluginErrors.listen((event) {
      // print(event.toJson().toString());
    });

    _analysisResultsNotification.listen(
        (event) => print('ANALYSISRESULT: ${event.toJson().toString()}'));

    _reloader.listen((event) {
      // TODO: replace set context with a simple update, based on the [event]
      // and the updated contents
      _requestSetContext();
    });

    _responses.listen((event) => print(event.toJson().toString()));

    await _initializationCompleter.future;
    await _requestSetContext();
  }

  final _initializationCompleter = Completer<void>();

  Future<List<AnalysisError>> requestAnalysisForFile(String file) async {
    //
    final content = io.File(file).readAsStringSync();
    final req =
        plugin.AnalysisUpdateContentParams({file: AddContentOverlay(content)});
    sendRequest(req.toRequest(_uuid.v4()));
    // final res = await server.handleAnalysisUpdateContent(req);

    final notification = await _notifications.firstWhere(
        (notification) => notification.event == kAnalysisResultsMethod);
    final analysisErrors =
        plugin.AnalysisErrorsParams.fromNotification(notification);
    return analysisErrors.errors;
  }

  void sendRequest(plugin.Request request) {
    // final jsonData = request.toJson();
    // print('from runner: ${jsonData.toString()}');
    channel.sendRequest(request);
  }

  Future<void> _requestSetContext() async {
    // print('setting context');
    await asyncRequest(
      plugin.AnalysisSetContextRootsParams([
        for (final contextRoot in contextRoots)
          plugin.ContextRoot(
            contextRoot.root.path,
            contextRoot.excludedPaths.toList(),
            optionsFile: contextRoot.optionsFile?.path,
          ),
      ]).toRequest(_uuid.v4()),
    );
    print('setting context compelete');
  }

  Future<plugin.Response> asyncRequest(plugin.Request request) {
    sendRequest(request);
    return _responses.firstWhere((response) => response.id == request.id);
  }

  /// Stop the command runner, sending a [plugin.PluginShutdownParams] request in the process.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    //TODO: this should be awaited
    sendRequest(plugin.PluginShutdownParams().toRequest(_uuid.v4()));
  }
}
