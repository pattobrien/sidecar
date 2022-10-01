import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

import 'logger.dart';

class PubspecUtilities {
  static Future<bool> isFlutterProject(
    String projectRootPath,
  ) async {
    final configFile = io.File(p.join(projectRootPath, 'pubspec.yaml'));
    if (configFile.existsSync()) {
      final contents = await configFile.readAsString();
      final pubspec = Pubspec.parse(contents);
      if (pubspec.dependencies.containsKey('flutter')) {
        return true;
      } else {
        return false;
      }
    } else {
      logger.stderr('PubspecUtilities pubspec not found');
      throw UnimplementedError('pubspec not found');
    }
  }
}
