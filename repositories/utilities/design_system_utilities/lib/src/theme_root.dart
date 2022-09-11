import 'dart:io';

import 'package:root_utilities/root_utilities.dart';
import 'package:path/path.dart' as p;

mixin ThemeRoot on LibDirectory {
  ThemeDirectory get theme => ThemeDirectory(p.join(path, 'theme'));
}

class ThemeDirectory extends ExtendedDirectory {
  const ThemeDirectory(super.path);

  File get themeFile => File(p.join(path, 'theme.dart'));
}
