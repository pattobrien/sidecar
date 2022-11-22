extension UriX on Uri {
  String get pathWithoutTrailingSlash {
    if (path.endsWith('/')) {
      return path.substring(0, path.length - 1);
    } else {
      return path;
    }
  }
}
