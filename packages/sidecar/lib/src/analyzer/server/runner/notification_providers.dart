// ignore_for_file: implementation_imports, unnecessary_lambdas

import 'dart:async';
import 'dart:io';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod/riverpod.dart';

import '../../../protocol/responses/responses.dart';
import '../../../services/services.dart';
import 'new_runner.dart';

final activeRunnerDirectory = Provider<Directory>(
  (ref) => Directory.current,
  name: 'activeRunnerDirectory',
);

final allContextsForRunnerProvider = Provider((ref) {
  final directory = ref.watch(activeRunnerDirectory);
  final service = ref.watch(activeProjectServiceProvider);
  return service.getAllContextsFromPath([directory.path]);
});

final activePrimaryContextsForRunnerProvider = Provider((ref) {
  final directory = ref.watch(activeRunnerDirectory);
  final service = ref.watch(activeProjectServiceProvider);
  return service.getActiveContextsFromPath([directory.path]);
});

final runnerResourceProviderProvider = Provider(
  (ref) => PhysicalResourceProvider.INSTANCE,
  name: 'runnerResourceProviderProvider',
);

final analyzerStreamProvider = StreamProvider.family<Object, NewSidecarRunner>(
  (ref, runner) async* {
    final _controller = StreamController<Object>();
    ref.onDispose(_controller.close);
    runner.receivePort.listen(
      (dynamic m) {
        print('got: ${m.toString()}');
        _controller.add(m as Object);
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

final analyzerNotificationStreamProvider =
    StreamProvider.family<SidecarNotification, NewSidecarRunner>(
  (ref, runner) => ref
      .watch(analyzerStreamProvider(runner).stream)
      .where((event) => event is Map<String, dynamic>)
      .map((event) => event as Map<String, dynamic>)
      .where((event) => event.containsKey('method') && !event.containsKey('id'))
      .map((event) {
    return SidecarNotification.fromJson(event);
  }),
  name: 'analyzerNotificationStreamProvider',
);

final analyzerResponseStreamProvider =
    StreamProvider.family<ResponseWrapper, NewSidecarRunner>(
  (ref, runner) => ref
      .watch(analyzerStreamProvider(runner).stream)
      .where((event) => event is Map<String, dynamic>)
      .map((event) {
        print('e: $event');
        return event as Map<String, dynamic>;
      })
      .where((event) => event.containsKey('method') && event.containsKey('id'))
      .map((event) => ResponseWrapper.fromJson(event)),
  name: 'analyzerResponseStreamProvider',
);
