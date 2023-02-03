import 'package:logging/logging.dart';

import '../duration_ext.dart';

export 'log_delegate_base.dart';
export 'plugin_channel_delegate.dart';

// final logger = Logger('sidecar');

T timedLog<T>(String message, T Function() function) {
  final watch = Stopwatch()..start();
  final result = function();
  // logger.info('${watch.elapsed.prettified()} $message');
  return result;
}

Future<T> timedLogAsync<T>(
    String message, Future<T> Function() function) async {
  final watch = Stopwatch()..start();
  final result = await function();
  // logger.info('${watch.elapsed.prettified()} $message');
  return result;
}
