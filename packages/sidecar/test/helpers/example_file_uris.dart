import 'package:package_config/package_config_types.dart';

const _sidecarPackagePath =
    'file:///Users/pattobrien/Development/sidecar/packages/sidecar/';
const sidecarAnnotationPackagePath =
    'file:///Users/pattobrien/Development/sidecar/packages/sidecar_annotations/';
const _pathPackagePath =
    'file:///Users/pattobrien/.pub-cache/hosted/pub.dartlang.org/path-1.7.0/';
final sidecarPackageUri = Uri.parse(_sidecarPackagePath);
final sidecarPackage = Package('sidecar', sidecarPackageUri);
final sidecarAnnotationsPackage =
    Package('sidecar_annotations', sidecarPackageUri);
final pathPackage = Package('path', Uri.parse(_pathPackagePath));
