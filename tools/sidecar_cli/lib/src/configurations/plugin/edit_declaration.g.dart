// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditDeclaration _$EditDeclarationFromJson(Map<String, dynamic> json) =>
    EditDeclaration(
      id: json['id'] as String,
      package: json['package'] as String,
      className: json['className'] as String,
      import: Uri.parse(json['import'] as String),
    );

Map<String, dynamic> _$EditDeclarationToJson(EditDeclaration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package': instance.package,
      'className': instance.className,
      'import': instance.import.toString(),
    };
