import '../exceptions/exceptions.dart';

class SidecarExceptionTuple<T> {
  const SidecarExceptionTuple(this._data, this._errors);

  final T _data;
  final List<SidecarNewException> _errors;

  List<SidecarNewException> get errors => _errors;
  T get data => _data;
}

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
