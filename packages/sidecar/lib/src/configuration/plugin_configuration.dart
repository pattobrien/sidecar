import 'package:json_annotation/json_annotation.dart';
import 'package:sidecar/sidecar.dart';

part 'plugin_configuration.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  explicitToJson: true,
)
class PluginConfiguration {
  const PluginConfiguration({
    required this.rules,
  });
  final List<LintConfiguration>? rules;

  factory PluginConfiguration.fromJson(Map json) =>
      _$PluginConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$PluginConfigurationToJson(this);
}
