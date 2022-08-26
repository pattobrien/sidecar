import 'package:json_annotation/json_annotation.dart';

part 'lint_configuration.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  explicitToJson: true,
)
class LintConfiguration {
  const LintConfiguration({
    required this.id,
  });

  factory LintConfiguration.fromJson(Map json) =>
      _$LintConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$LintConfigurationToJson(this);

  final String id;
}
