import 'dart:io';

import 'package:package_config/package_config_types.dart';

final _pubCachePath = Platform.environment['PUB_CACHE'];
final _sidecarPackagePath = Directory.current;
final _pathPackagePath = '$_pubCachePath/hosted/pub.dartlang.org/path-1.7.0/';
final sidecarPackageUri = _sidecarPackagePath;
final sidecarPackage = Package('sidecar', sidecarPackageUri.uri);
final sidecarAnnotationsPackage =
    Package('sidecar_annotations', sidecarPackageUri.uri);
final pathPackage =
    Package('path', Uri(scheme: 'file', path: _pathPackagePath));
