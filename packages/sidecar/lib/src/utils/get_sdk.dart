import 'dart:io' as io;

import 'package:analyzer/file_system/file_system.dart';
import 'package:cli_util/cli_util.dart' as util;
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../services/active_project_service.dart';

String getDartSdkPathForPackage(Uri root, ResourceProvider resourceProvider) {
  final flutterSdk = getFlutterSdkForPackage(root, resourceProvider);
  if (flutterSdk == null) return util.getSdkPath();
  print('flutter sdk toFilePath: ${flutterSdk.toFilePath()}');
  final resolvedUri = flutterSdk.resolve(p.join('bin', 'cache', 'dart-sdk'));
  return resolvedUri.toFilePath();
}

Uri? getFlutterSdkForPackage(Uri root, ResourceProvider resourceProvider) {
  final service = ActiveProjectService(resourceProvider: resourceProvider);
  final packageConfig = service.getPackageConfig(root);
  final flutterPackage = packageConfig.packages
      .firstWhereOrNull((package) => package.name == 'flutter')
      ?.root;
  if (flutterPackage == null) return null;
  print('flutter package file path:  ${flutterPackage.toFilePath()}');
  final flutterPackageDirectory = io.Directory.fromUri(flutterPackage);

  print('flutter package directory:  ${flutterPackageDirectory.path}');
  final sdkDirectory = flutterPackageDirectory.parent.parent;
  print('flutter sdk Directory:  ${sdkDirectory.path}');
  return sdkDirectory.uri;
}
