import 'package:analyzer/file_system/file_system.dart';
import 'package:cli_util/cli_util.dart' as util;
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../services/active_project_service.dart';

String getDartSdkPathForPackage(Uri root, ResourceProvider resourceProvider) {
  final flutterSdk = getFlutterSdkForPackage(root, resourceProvider);
  if (flutterSdk == null) return util.getSdkPath();
  print('flutter sdk toFilePath: ${flutterSdk.path}');
  final dartSdkUri = flutterSdk
      .getChildAssumingFolder(p.context.join('bin', 'cache', 'dart-sdk'));
  print('dart sdk path: ${dartSdkUri.path}');
  return dartSdkUri.path;
}

Folder? getFlutterSdkForPackage(Uri root, ResourceProvider resourceProvider) {
  final service = ActiveProjectService(resourceProvider: resourceProvider);
  final packageConfig = service.getPackageConfig(root);
  final flutterPackage = packageConfig.packages
      .firstWhereOrNull((package) => package.name == 'flutter')
      ?.root;
  if (flutterPackage == null) return null;
  final normalizedFlutterPath =
      p.context.normalize(flutterPackage.toFilePath());
  // print('flutter package file path:  ${flutterPackage.toFilePath()}');
  // print('normalized flutter package path: $normalizedFlutterPath');
  final flutterPackageFolder =
      resourceProvider.getFolder(normalizedFlutterPath);
  // final flutterPackageDirectory = io.Directory.fromUri(flutterPackage);

  // print('flutter package directory:  ${flutterPackageFolder.path}');
  final sdkDirectory = flutterPackageFolder.parent.parent;
  // print('flutter sdk Directory:  ${sdkDirectory.path}');
  return sdkDirectory;
}
