import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';

final logDelegateProvider = Provider<LogDelegateBase>(
  (ref) {
    throw UnimplementedError();
  },
  dependencies: const [],
  name: 'logDelegateProvider',
);
