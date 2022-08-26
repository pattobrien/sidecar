// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lint_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LintConfiguration _$LintConfigurationFromJson(Map json) => $checkedCreate(
      'LintConfiguration',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['id'],
        );
        final val = LintConfiguration(
          id: $checkedConvert('id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$LintConfigurationToJson(LintConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
