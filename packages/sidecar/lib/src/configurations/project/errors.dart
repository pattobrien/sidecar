import 'package:source_span/source_span.dart';

class SidecarException implements Exception {}

class MissingSidecarYamlConfiguration implements SidecarException {
  const MissingSidecarYamlConfiguration();

  @override
  String toString() {
    const message = 'No sidecar.yaml configuration found.';
    return 'MissingSidecarYamlConfiguration: $message';
  }
}

class InvalidSeverityException implements SidecarException {
  const InvalidSeverityException(this.invalidValue);

  final String invalidValue;
}

class InvalidConfigurationException implements SidecarException {
  const InvalidConfigurationException(this.message);

  final MapEntry<SourceSpan, String> message;
}

class InvalidIncludesException implements SidecarException {
  const InvalidIncludesException(this.message);

  final MapEntry<SourceSpan, String> message;
}

class InvalidSidecarConfiguration implements SidecarException {}
