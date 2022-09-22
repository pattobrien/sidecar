class Logger {
  const Logger();
  static log(String message) =>
      print('${DateTime.now().toIso8601String()} $message');
}
