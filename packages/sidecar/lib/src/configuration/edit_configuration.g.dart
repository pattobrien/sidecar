// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditConfiguration _$EditConfigurationFromJson(Map json) => $checkedCreate(
      'EditConfiguration',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['id'],
        );
        final val = EditConfiguration(
          id: $checkedConvert('id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$EditConfigurationToJson(EditConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
