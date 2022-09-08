// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lint_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LintDeclaration _$LintDeclarationFromJson(Map<String, dynamic> json) =>
    LintDeclaration(
      id: json['id'] as String,
      package: json['package'] as String?,
      className: json['className'] as String?,
      import:
          json['import'] == null ? null : Uri.parse(json['import'] as String),
    );

Map<String, dynamic> _$LintDeclarationToJson(LintDeclaration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package': instance.package,
      'className': instance.className,
      'import': instance.import?.toString(),
    };
