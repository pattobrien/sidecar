import 'package:tuple/tuple.dart';

import '../builders/config_exceptions.dart';

typedef SidecarExceptionTuple<T> = Tuple2<T, List<SidecarNewException>>;

class SidecarException implements Exception {}

class MissingSidecarYamlConfiguration implements SidecarException {
  const MissingSidecarYamlConfiguration();

  @override
  String toString() {
    const message = 'No sidecar.yaml configuration found.';
    return 'MissingSidecarYamlConfiguration: $message';
  }
}

class InvalidSidecarConfiguration implements SidecarException {}

class InvalidSeverityException implements SidecarException {
  const InvalidSeverityException(this.invalidValue);

  final String invalidValue;
}
