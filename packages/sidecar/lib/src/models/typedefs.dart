typedef MapDecoder = Object Function(Map json);

class EmptyConfiguration implements Exception {}

class IncorrectConfiguration implements Exception {
  const IncorrectConfiguration(this.error, this.stackTrace);
  final Object error;
  final StackTrace stackTrace;
}
