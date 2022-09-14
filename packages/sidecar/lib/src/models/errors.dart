class EmptyConfiguration implements Exception {
  const EmptyConfiguration(this.error);
  final Object error;
}

class IncorrectConfiguration implements Exception {
  const IncorrectConfiguration(this.error, this.stackTrace, this.lintName);
  final String lintName;
  final Object error;
  final StackTrace stackTrace;
}
