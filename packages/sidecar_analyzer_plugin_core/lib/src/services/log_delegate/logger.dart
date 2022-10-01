class Logger {
  const Logger();
  static void log(String message) =>
      print('${DateTime.now().toIso8601String()} $message');
}
