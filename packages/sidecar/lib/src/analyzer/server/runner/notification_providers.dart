// ignore_for_file: implementation_imports, unnecessary_lambdas

import 'dart:async';
import 'dart:io';
import 'dart:io' as io;

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/instrumentation/file_instrumentation.dart';
import 'package:analyzer/instrumentation/instrumentation.dart';
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../../../utils/file_paths.dart';

final activeRunnerDirectory = Provider<Directory>(
  (ref) => Directory.current,
  name: 'activeRunnerDirectory',
);
final runnerResourceProviderProvider = Provider(
  (ref) => PhysicalResourceProvider.INSTANCE,
  name: 'runnerResourceProviderProvider',
);

final masterServerChannel = Provider<plugin.DiscoveredServerIsolateChannel>(
  (ref) {
    final dir = ref.watch(activeRunnerDirectory);
    final pluginFile =
        io.File(join(dir.path, kDartTool, 'sidecar', 'sidecar.dart'));
    final packagesFile = io.File(join(dir.path, kDartTool, kPackageConfigJson));
    final logFile = io.File(join(dir.path, kDartTool, 'log.txt'));
    assert(pluginFile.existsSync(), 'plugin executable does not exist');
    assert(packagesFile.existsSync(), 'plugin executable does not exist');
    final logger = FileInstrumentationLogger(logFile.path);
    final service = InstrumentationLogAdapter(logger);
    return plugin.DiscoveredServerIsolateChannel(
      pluginFile.uri,
      packagesFile.uri,
      service,
    );
  },
  name: 'masterServerChannel',
);

final serverChannelStreamProvider = StreamProvider<Object>(
  (ref) {
    final _controller = StreamController<Object>();
    final serverChannel = ref.watch(masterServerChannel);
    ref.onDispose(_controller.close);
    serverChannel.listen(
      _controller.add,
      _controller.add,
      onError: (dynamic e) => _controller.addError(e as Object),
      onDone: _controller.close,
    );
    return _controller.stream;
  },
  name: 'serverChannelStreamProvider',
);

final serverChannelNotificationStreamProvider =
    StreamProvider<plugin.Notification>(
  (ref) => ref
      .watch(serverChannelStreamProvider.stream)
      .where((event) => event is plugin.Notification)
      .map((event) => event as plugin.Notification),
  name: 'serverChannelNotificationStreamProvider',
);

final serverChannelResponseStreamProvider = StreamProvider<plugin.Response>(
  (ref) => ref
      .watch(serverChannelStreamProvider.stream)
      .where((event) => event is plugin.Response)
      .map((event) => event as plugin.Response),
  name: 'serverChannelResponseStreamProvider',
);
