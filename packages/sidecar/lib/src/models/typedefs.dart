import '../../sidecar.dart';

typedef MapDecoder = Object Function(Map json);

class EmptyConfiguration implements Exception {
  const EmptyConfiguration(this.error);
  final Object error;
}

class IncorrectConfiguration implements Exception {
  const IncorrectConfiguration(this.error, this.stackTrace);
  final Object error;
  final StackTrace stackTrace;
}
