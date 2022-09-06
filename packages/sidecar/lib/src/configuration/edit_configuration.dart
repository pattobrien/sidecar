import 'package:json_annotation/json_annotation.dart';

part 'edit_configuration.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  explicitToJson: true,
)
class EditConfiguration {
  const EditConfiguration({
    required this.id,
  });

  factory EditConfiguration.fromJson(Map json) =>
      _$EditConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$EditConfigurationToJson(this);

  final String id;
}
