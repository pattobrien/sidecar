import 'dart:io';
import '../utils.dart';
import 'package:path/path.dart' as p;

class MacosDirectory extends ExtendedDirectory {
  MacosDirectory(super.path);
  File get podFile => File(p.join(path, 'Podfile'));
}
