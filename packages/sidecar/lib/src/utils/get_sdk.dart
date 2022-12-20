import 'dart:io' as io;

import 'package:analyzer/file_system/file_system.dart';
import 'package:cli_util/cli_util.dart' as util;
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../services/active_project_service.dart';

String getDartSdkPathForPackage(Uri root, ResourceProvider resourceProvider) {
  final flutterSdk = getFlutterSdkForPackage(root, resourceProvider);
  if (flutterSdk == null) return util.getSdkPath();
  return flutterSdk.resolve(p.join('bin', 'cache', 'dart-sdk')).path;
}

Uri? getFlutterSdkForPackage(Uri root, ResourceProvider resourceProvider) {
  final service = ActiveProjectService(resourceProvider: resourceProvider);
  final packageConfig = service.getPackageConfig(root);
  final flutterPackage = packageConfig.packages
      .firstWhereOrNull((package) => package.name == 'flutter')
      ?.root;
  if (flutterPackage == null) return null;
  final flutterPackageDirectory = io.Directory.fromUri(flutterPackage);
  final sdkDirectory = flutterPackageDirectory.parent.parent;
  return sdkDirectory.uri;
}
