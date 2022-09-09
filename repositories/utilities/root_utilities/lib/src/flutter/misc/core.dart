import 'package:root_utilities/root_utilities.dart';

import 'package:path/path.dart' as p;

mixin Core on LibDirectory {
  CoreDirectory get core => CoreDirectory(p.join(path, 'core'));
}

class CoreDirectory extends ExtendedDirectory {
  CoreDirectory(super.path);
}
