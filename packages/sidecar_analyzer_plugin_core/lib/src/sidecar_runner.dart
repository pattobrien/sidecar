// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/instrumentation/instrumentation.dart';

import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;

import 'package:cli_util/cli_util.dart';
import 'package:uuid/uuid.dart';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'byte_store_ext.dart';
import 'constants.dart';

const _uuid = Uuid();

class SidecarRunner {
  SidecarRunner(this.server, this.root) {
    server.start(_clientChannel);
  }

  final SidecarAnalyzerPlugin server;
  final Directory root;

  LogDelegate get delegate => server.delegate;

  bool _closed = false;
  final _sdkPath = getSdkPath();

  late final _clientChannel =
      plugin.PluginIsolateChannel(_receivePort.sendPort);
  late final ResourceProvider _resourceProvider = server.resourceProvider;

  /// Used to send requests to sidecar_analyzer_plugin
  late final SendPort _sendPort;

  /// Used to receive responses and notifications from sidecar_analyzer_plugin
  late final ReceivePort _receivePort = ReceivePort();

  late final Stream<Object?> _receivePortStream =
      _receivePort.asBroadcastStream();

  late final Stream<plugin.Notification> _notifications = _receivePortStream
      .where((event) => event is Map)
      .map((event) => event! as Map)
      .where((event) => event.containsKey(plugin.Notification.EVENT))
      .map(plugin.Notification.fromJson);

  /// Lints emitted by the plugin
  late final Stream<plugin.AnalysisErrorsParams> _lints = _notifications
      .where((e) => e.event == 'analysis.errors')
      .map(plugin.AnalysisErrorsParams.fromNotification);

  late final Stream<Map> _reloader = _notifications
      .where((e) => e.event == 'sidecar.auto_reload')
      .map((e) => <dynamic, dynamic>{});

  // /// The [Notification]s emitted by the plugin
  // late final Stream<plugin.PrintNotification> messages = notifications
  //     .where((e) => e.event == PrintNotification.key)
  //     .map(plugin.PrintNotification.fromNotification);

  /// The [Response]s emitted by the plugin
  late final Stream<plugin.Response> _responses = _receivePortStream
      .where((event) => event is Map<String, Object?>)
      .map((event) => event! as Map<String, Object?>)
      .where((e) => e.containsKey(plugin.Response.ID))
      .map(plugin.Response.fromJson);

  // final instrumentationService = InstrumentationService.NULL_SERVICE;

  // This channel is where notifications are received from the plugin.
  // If we wish to receive those notifications, we need to subscribe to the channel.
  // late final plugin.BuiltInServerIsolateChannel channel =
  //     plugin.BuiltInServerIsolateChannel(
  //         (sPort) => sendPort = sPort, pluginName, instrumentationService);

  // /// Error [Notification]s.
  // late final Stream<plugin.PluginErrorParams> pluginErrors =
  //     StreamGroup.mergeBroadcast([
  //   // Manual error notifications from the plugin
  //   _notifications
  //       .where((e) => e.event == 'plugin.error')
  //       .map(plugin.PluginErrorParams.fromNotification),

  //   // When the receivePort is passed to Isolate.onError, error events are
  //   // received as ["error", "stackTrace"]
  //   _receivePortStream
  //       .where((event) => event is List)
  //       .cast<List>()
  //       .map((event) {
  //     // The plugin had an uncaught error.
  //     if (event.length != 2) {
  //       throw UnsupportedError(
  //         'Only ["error", "stackTrace"] list messages are supported',
  //       );
  //     }

  //     final error = event.first.toString();
  //     final stackTrace = event.last.toString();
  //     return plugin.PluginErrorParams(false, error, stackTrace);
  //   }),
  // ]);

  /// Errors for [Request]s that failed.
  late final Stream<plugin.RequestError> responseErrors =
      _responses.where((e) => e.error != null).map((e) => e.error!);

  late final ContextLocator contextLocator =
      ContextLocator(resourceProvider: _resourceProvider);

  List<ContextRoot> get allContextRoots =>
      contextLocator.locateRoots(includedPaths: [root.path]);

  List<ContextRoot> get contextRoots =>
      allContextRoots; //.where((element) => false)

  /// Starts the plugin and sends the necessary requests for initializing it.
  Future<void> initialize() async {
    _notifications.listen((request) {
      delegate.sidecarVerboseMessage('>> ${request.event} ${request.params}');
    });

    _reloader.listen((event) {
      delegate.sidecarMessage('\n\nHOTRELOAD.......\n\n');
      _requestSetContext();
    });

    _sendPort = await _receivePortStream
        .where((event) => event is SendPort)
        .cast<SendPort>()
        .first;

    sendRequest(
      plugin.PluginVersionCheckParams(
        _resourceProvider.getByteStorePath(pluginName),
        _sdkPath,
        pluginVersion,
      ).toRequest(_uuid.v4()),
    );

    _requestSetContext();

    delegate.sidecarVerboseMessage('done initializing...');
  }

  void sendRequest(plugin.Request request) {
    final jsonData = request.toJson();
    final encodedRequest = json.encode(jsonData);
    delegate.sidecarVerboseMessage('>> $pluginName $encodedRequest');
    _sendPort.send(jsonData);
  }

  void _requestSetContext() {
    sendRequest(
      plugin.AnalysisSetContextRootsParams([
        for (final contextRoot in contextRoots)
          plugin.ContextRoot(
            contextRoot.root.path,
            contextRoot.excludedPaths.toList(),
            optionsFile: contextRoot.optionsFile?.path,
          ),
      ]).toRequest(_uuid.v4()),
    );
  }

  // Obtains the list of lints for the current workspace.
  // Future<List<plugin.AnalysisErrorsParams>> getLints(
  //     {required bool reload}) async {
  //   final result = <String, plugin.AnalysisErrorsParams>{};

  //   StreamSubscription? sub;
  //   try {
  //     // channel.listen((response) {
  //     //   print('notification: ${response.toString()}');
  //     // }, (notification) {
  //     //   print('notification: ${notification.toString()}');
  //     // });
  //     // sub = channel.lints.listen((event) => result[event.file] = event);
  //     // receivePortStream = receivePort.asBroadcastStream();
  //     // channel.sendRequest(AwaitAnalysisDoneParams(reload: reload));
  //     // return result.values.toList()..sort((a, b) => a.file.compareTo(b.file));
  //     return [];
  //   } finally {
  //     await sub?.cancel();
  //   }
  // }

  /// Stop the command runner, sending a [PluginShutdownParams] request in the process.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;

    try {
      sendRequest(plugin.PluginShutdownParams().toRequest(_uuid.v4()));
    } finally {
      _clientChannel.close();
      _receivePort.close();
    }
  }
}
