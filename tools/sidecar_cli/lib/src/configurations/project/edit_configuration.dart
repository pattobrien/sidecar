import 'package:json_annotation/json_annotation.dart';

part 'edit_configuration.g.dart';

@JsonSerializable(anyMap: true)
class EditConfiguration {
  const EditConfiguration({
    required this.packageName,
    required this.editId,
    this.enabled = true,
    required this.configuration,
  });

  final String packageName;
  final String editId;
  final bool enabled;
  final Map<dynamic, dynamic> configuration;

  factory EditConfiguration.fromJson(Map<String, dynamic> json) =>
      _$EditConfigurationFromJson(json);
}
