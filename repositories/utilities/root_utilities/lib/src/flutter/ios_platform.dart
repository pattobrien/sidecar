import 'dart:io';
import '../utils.dart';
import 'package:path/path.dart' as p;

class IosDirectory extends ExtendedDirectory {
  IosDirectory(super.path);
  File get podFile => File(p.join(path, 'Podfile'));
}
