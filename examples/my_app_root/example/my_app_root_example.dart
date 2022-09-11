import 'dart:io';

import 'package:root_utilities/root_utilities.dart';

/// This is an example app root definition, customized for a specific application
/// using Mixins.
class MyAppRoot extends FlutterAppRoot with RootAssets {
  MyAppRoot(super.root);

  @override
  MyLibDir get lib => MyLibDir(root.path);
}

class MyLibDir extends LibDirectory with Core {
  MyLibDir(super.path);
}

void main() {
  final myWorkspaceDirectory = Directory.current;

  final myApp = MyAppRoot(myWorkspaceDirectory);

  final assetsDirectory = myApp.assets;
  final mainFile = myApp.lib.mainFile;
  final featuresFolder = myApp.lib.features;

  // by
  final customizedLib = myApp.lib;
  final features = customizedLib.features;
  final core = customizedLib.core;

  print('');
  print('root directory:    ${myWorkspaceDirectory.path}');
  print('');
  print('assets folder:     ${assetsDirectory.path}');
  print('main() file:       ${mainFile.path}');
  print('features folder:   ${featuresFolder.path}');
  print('');
}
