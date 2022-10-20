import 'dart:io';
import 'logger.dart';

Directory homeDirectory() {
  final homePath = Platform.environment['HOME'];
  logger.trace('home directory: $homePath');
  if (homePath != null) {
    final homeDirectory = Directory(homePath);
    return homeDirectory;
  } else {
    throw UnimplementedError('No home directory found.');
  }
}
