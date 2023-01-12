extension UriX on Uri {
  String get pathNoTrailingSlash {
    if (path.endsWith('/') || path.endsWith(r'\')) {
      final editedPath = path.substring(0, path.length - 1);
      return Uri.parse(editedPath).toFilePath();
    } else {
      return path;
    }
  }
}
