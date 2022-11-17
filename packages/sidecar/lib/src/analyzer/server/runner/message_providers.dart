import 'package:riverpod/riverpod.dart';

import '../../../protocol/communication/communication.dart';
import '../../../protocol/logging/log_record.dart';
import 'sidecar_runner.dart';

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

final analyzerLogStreamProvider =
    StreamProvider.family<LogRecord, SidecarRunner>(
  (ref, runner) => ref
      .watch(analyzerMessageStreamProvider(runner).stream)
      .where((event) => event is LogMessage)
      .map((event) => (event as LogMessage).record),
  name: 'analyzerLogStreamProvider',
);

final analyzerResponseStreamProvider =
    StreamProvider.family<ResponseMessage, SidecarRunner>(
  (ref, runner) => ref
      .watch(analyzerMessageStreamProvider(runner).stream)
      .where((event) => event is ResponseMessage)
      .map((event) => event as ResponseMessage),
  name: 'analyzerResponseStreamProvider',
);
