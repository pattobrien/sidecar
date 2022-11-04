// ignore_for_file: implementation_imports, unnecessary_lambdas

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../../protocol/responses/responses.dart';
import 'sidecar_runner.dart';

final analyzerStreamProvider = StreamProvider.family<Object, SidecarRunner>(
  (ref, runner) async* {
    final _controller = StreamController<Object>();
    ref.onDispose(_controller.close);
    runner.receivePort.listen(
      (dynamic m) {
        if (m is SendPort) runner.sendPort = m;
        if (m is String) {
          try {
            print('got: $m');
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
    await for (final event in _controller.stream) {
      yield event;
    }
  },
  name: 'serverChannelStreamProvider',
);

final analyzerMessageStreamProvider =
    StreamProvider.family<SidecarMessage, SidecarRunner>((ref, runner) {
  final stream = ref.watch(analyzerStreamProvider(runner).stream);
  return stream.where((event) => event is Map<String, dynamic>).map((event) {
    final map = event as Map<String, dynamic>;
    return SidecarMessage.fromJson(map);
  });
});

final analyzerNotificationStreamProvider =
    StreamProvider.family<SidecarNotification, SidecarRunner>(
  (ref, runner) => ref
      .watch(analyzerMessageStreamProvider(runner).stream)
      .map((event) => event)
      .where((event) => event is NotificationMessage)
      .map((event) => (event as NotificationMessage).notification),
  name: 'analyzerNotificationStreamProvider',
);

final analyzerResponseStreamProvider =
    StreamProvider.family<ResponseMessage, SidecarRunner>(
  (ref, runner) => ref
      .watch(analyzerMessageStreamProvider(runner).stream)
      .where((event) => event is ResponseMessage)
      .map((event) => event as ResponseMessage),
  name: 'analyzerResponseStreamProvider',
);
