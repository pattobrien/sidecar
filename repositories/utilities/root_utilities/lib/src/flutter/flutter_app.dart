import 'package:path/path.dart' as p;

import '../root.dart';

import 'ios_platform.dart';
import 'macos_platform.dart';

abstract class FlutterAppRoot extends Root {
  FlutterAppRoot(super.root);

  IosDirectory get ios => IosDirectory(p.join(root.path, 'ios'));
  MacosDirectory get macos => MacosDirectory(p.join(root.path, 'macos'));
}
