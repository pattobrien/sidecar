// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ActivePackage _$$_ActivePackageFromJson(Map<String, dynamic> json) =>
    _$_ActivePackage(
      root: Uri.parse(json['root'] as String),
      sidecarOptionsFile: Uri.parse(json['sidecarOptionsFile'] as String),
      sidecarPluginPackage: Uri.parse(json['sidecarPluginPackage'] as String),
      sidecarPackages: (json['sidecarPackages'] as List<dynamic>)
          .map((e) => Uri.parse(e as String))
          .toList(),
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => Uri.parse(e as String))
          .toList(),
      workspaceScope: (json['workspaceScope'] as List<dynamic>?)
          ?.map((e) => Uri.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$$_ActivePackageToJson(_$_ActivePackage instance) =>
    <String, dynamic>{
      'root': instance.root.toString(),
      'sidecarOptionsFile': instance.sidecarOptionsFile.toString(),
      'sidecarPluginPackage': instance.sidecarPluginPackage.toString(),
      'sidecarPackages':
          instance.sidecarPackages.map((e) => e.toString()).toList(),
      'dependencies': instance.dependencies.map((e) => e.toString()).toList(),
      'workspaceScope':
          instance.workspaceScope?.map((e) => e.toString()).toList(),
    };
