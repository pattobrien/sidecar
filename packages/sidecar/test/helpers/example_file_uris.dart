import 'dart:io';

import 'package:package_config/package_config_types.dart';

final _pubCachePath = Platform.environment['PUB_CACHE'];
final _sidecarPackagePath = Directory.current;
// const sidecarAnnotationPackagePath =
//     'file:///Users/pattobrien/Development/sidecar/packages/sidecar_annotations/';
final _pathPackagePath =
    'file://$_pubCachePath/hosted/pub.dartlang.org/path-1.7.0/';
final sidecarPackageUri = _sidecarPackagePath;
final sidecarPackage = Package('sidecar', sidecarPackageUri.uri);
final sidecarAnnotationsPackage =
    Package('sidecar_annotations', sidecarPackageUri.uri);
final pathPackage = Package('path', Uri.parse(_pathPackagePath));
