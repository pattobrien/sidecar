import 'package:path/path.dart' as p;

import '../../root.dart';
import '../../utils.dart';

mixin RootAssets on Root {
  AssetsDirectory get assets => AssetsDirectory(p.join(root.path, 'assets'));
}

mixin LibAssets on LibDirectory {
  AssetsDirectory get assets => AssetsDirectory(p.join(path, 'assets'));
}

class AssetsDirectory extends ExtendedDirectory {
  AssetsDirectory(super.path);
}
