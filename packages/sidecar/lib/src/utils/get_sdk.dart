import 'package:analyzer/file_system/file_system.dart';
import 'package:cli_util/cli_util.dart' as util;
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../services/active_project_service.dart';

String getDartSdkPathForPackage(Uri root, ResourceProvider resourceProvider) {
  final flutterSdk = getFlutterSdkForPackage(root, resourceProvider);
  if (flutterSdk == null) return util.getSdkPath();
  final dartSdkUri = flutterSdk
      .getChildAssumingFolder(p.context.join('bin', 'cache', 'dart-sdk'));
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
  final flutterPackageFolder =
      resourceProvider.getFolder(normalizedFlutterPath);

  return flutterPackageFolder.parent.parent;
}

String convertUriToPath(Uri uri) {
  return p.normalize(uri.toFilePath());
}
