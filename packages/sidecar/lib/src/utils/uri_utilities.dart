extension UriX on Uri {
  static Uri package(String name, String path) => Uri(
        scheme: 'package',
        path: '$name/$path',
      );
}
