import 'dart:io';

Directory homeDirectory() {
  final homePath = Platform.environment['HOME'];
  print('home directory: $homePath');
  if (homePath != null) {
    final homeDirectory = Directory(homePath);
    return homeDirectory;
  } else {
    throw UnimplementedError('No home directory found.');
  }
}
