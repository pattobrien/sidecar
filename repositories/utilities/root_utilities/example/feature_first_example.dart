import 'dart:io';

import 'package:root_utilities/root_utilities.dart';

void main() {
  final myWorkspaceDirectory = Directory.current;

  final myApp = MyAppRoot(myWorkspaceDirectory);

  final assetsDirectory = myApp.assets;
  final mainFile = myApp.lib.mainFile;
  final featuresFolder = myApp.lib.features;

  print('');
  print('root directory:    ${myWorkspaceDirectory.path}');
  print('');
  print('assets folder:     ${assetsDirectory.path}');
  print('main() file:       ${mainFile.path}');
  print('features folder:   ${featuresFolder.path}');
  print('');
}

class MyAppRoot extends FlutterAppRoot with RootAssets {
  MyAppRoot(super.root);
}
