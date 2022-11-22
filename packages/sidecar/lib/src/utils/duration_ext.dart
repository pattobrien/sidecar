extension DurationX on Duration {
  String prettified() {
    if (inSeconds >= 1) {
      final countS = '${inSeconds.remainder(1000)}';
      final countMs = inMilliseconds.remainder(1000).toString().padLeft(3, '0');
      return '$countS.${countMs}s';
    } else {
      final countMs = '${inMilliseconds.remainder(1000)}'.padLeft(3);
      final countUs = inMicroseconds.remainder(1000).toString().padLeft(3, '0');
      return '$countMs.${countUs}ms';
    }
  }
}
