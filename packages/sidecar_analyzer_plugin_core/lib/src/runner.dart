import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/instrumentation/instrumentation.dart';
// import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:cli_util/cli_util.dart';
import 'package:uuid/uuid.dart';

import 'byte_store_ext.dart';

const pluginName = 'sidecar_analyzer_plugin';

// this cannot be any random number for some reason
// ("Plugin is not compatible." error is thrown)
const pluginVersion = '1.0.0-alpha.0';
const _uuid = Uuid();

class Runner {
  Runner(this.server, this.root) {
    // channel.listen((response) {
    //   print('notification: ${response.toString()}');
    // }, (notification) {
    //   print('notification: ${notification.toString()}');
    // });
    server.start(clientChannel);
    // initialize();
  }

  final plugin.ServerPlugin server;
  final Directory root;

  bool closed = false;
  final sdkPath = getSdkPath();

  final instrumentationService = InstrumentationService.NULL_SERVICE;

  late final clientChannel = plugin.PluginIsolateChannel(receivePort.sendPort);
  late final ResourceProvider resourceProvider = server.resourceProvider;

  late final ReceivePort receivePort = ReceivePort();

  late final Stream<Object?> receivePortStream =
      receivePort.asBroadcastStream();

  late final Stream<plugin.Notification> notifications = receivePortStream
      .where((event) => event is Map)
      .map((event) => event! as Map)
      .where((event) => event.containsKey(plugin.Notification.EVENT))
      .map(plugin.Notification.fromJson);

  late final SendPort sendPort;

  // This channel is where notifications are received from the plugin.
  // If we wish to receive those notifications, we need to subscribe to the channel.
  // late final plugin.BuiltInServerIsolateChannel channel =
  //     plugin.BuiltInServerIsolateChannel(
  //         (sPort) => sendPort = sPort, pluginName, instrumentationService);

  late final ContextLocator contextLocator =
      ContextLocator(resourceProvider: resourceProvider);

  late final List<ContextRoot> allContextRoots =
      contextLocator.locateRoots(includedPaths: [root.path]);

  late final List<ContextRoot> contextRoots =
      allContextRoots; //.where((element) => false)

  /// Starts the plugin and sends the necessary requests for initializing it.
  Future<void> initialize() async {
    print('initializing...');

    receivePortStream.listen((request) {
      print('receivePortStream: ${request.runtimeType}');
    });
    notifications.listen((request) {
      print('notifications: ${request.toString()}');
    });
    sendPort = await receivePortStream
        .where((event) => event is SendPort)
        .cast<SendPort>()
        .first;
    sendRequest(
      plugin.PluginVersionCheckParams(
        resourceProvider.getByteStorePath(pluginName),
        sdkPath,
        pluginVersion,
      ).toRequest(_uuid.v4()),
    );
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
    // await channel.listen(
    //   (response) => print(response.toJson()),
    //   (notification) => print(notification.toJson()),
    // );
    print('done initializing...');
  }

  void sendRequest(plugin.Request request) {
    // var sendPort = _sendPort;
    // if (sendPort != null) {
    var jsonData = request.toJson();
    var encodedRequest = json.encode(jsonData);
    // instrumentationService.logPluginRequest(pluginName, encodedRequest);
    print('$pluginName, $encodedRequest');
    sendPort.send(jsonData);
    // }
  }

  // late final Stream<Object?> receivePortStream;

  // Obtains the list of lints for the current workspace.
  Future<List<plugin.AnalysisErrorsParams>> getLints(
      {required bool reload}) async {
    final result = <String, plugin.AnalysisErrorsParams>{};

    StreamSubscription? sub;
    try {
      // channel.listen((response) {
      //   print('notification: ${response.toString()}');
      // }, (notification) {
      //   print('notification: ${notification.toString()}');
      // });
      // sub = channel.lints.listen((event) => result[event.file] = event);
      // receivePortStream = receivePort.asBroadcastStream();
      // channel.sendRequest(AwaitAnalysisDoneParams(reload: reload));
      // return result.values.toList()..sort((a, b) => a.file.compareTo(b.file));
      return [];
    } finally {
      await sub?.cancel();
    }
  }

  /// Stop the command runner, sending a [PluginShutdownParams] request in the process.
  Future<void> close() async {
    if (closed) return;
    closed = true;

    try {
      // channel.sendRequest(plugin.PluginShutdownParams().toRequest(_uuid.v4()));
    } finally {
      clientChannel.close();
      receivePort.close();
    }
  }
}

extension on plugin.BuiltInServerIsolateChannel {
  // late final Stream<Object?> _receivePortStream =
  //     receivePort.asBroadcastStream();
  /// Lints emitted by the plugin
  // late final Stream<plugin.AnalysisErrorsParams> lints = listen().asStream()
  //     .where((e) => e.event == 'analysis.errors')
  //     .map(AnalysisErrorsParams.fromNotification);
}
