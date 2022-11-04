// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ContextPath _$$_ContextPathFromJson(Map<String, dynamic> json) =>
    _$_ContextPath(
      includesPaths: (json['includesPaths'] as List<dynamic>)
          .map((e) => Uri.parse(e as String))
          .toList(),
      excludesPaths: (json['excludesPaths'] as List<dynamic>?)
          ?.map((e) => Uri.parse(e as String))
          .toList(),
      optionsFile: json['optionsFile'] == null
          ? null
          : Uri.parse(json['optionsFile'] as String),
      packagesFile: json['packagesFile'] == null
          ? null
          : Uri.parse(json['packagesFile'] as String),
    );

Map<String, dynamic> _$$_ContextPathToJson(_$_ContextPath instance) =>
    <String, dynamic>{
      'includesPaths': instance.includesPaths.map((e) => e.toString()).toList(),
      'excludesPaths':
          instance.excludesPaths?.map((e) => e.toString()).toList(),
      'optionsFile': instance.optionsFile?.toString(),
      'packagesFile': instance.packagesFile?.toString(),
    };
