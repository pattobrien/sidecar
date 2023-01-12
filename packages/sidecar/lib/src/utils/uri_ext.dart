extension UriX on Uri {
  String get pathNoTrailingSlash {
    if (toFilePath().endsWith('/') || toFilePath().endsWith(r'\')) {
      final editedPath = toFilePath().substring(0, toFilePath().length - 1);
      return Uri.file(editedPath).toFilePath();
    } else {
      return toFilePath();
    }
  }
}
