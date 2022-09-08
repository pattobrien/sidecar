import 'package:json_annotation/json_annotation.dart';

part 'example_lint_config.g.dart';

@JsonSerializable()
class ExampleLintConfig {
  const ExampleLintConfig({
    this.property1,
    this.property2,
  });

  factory ExampleLintConfig.fromJson(Map<String, dynamic> json) =>
      _$ExampleLintConfigFromJson(json);

  final String? property1;
  final String? property2;

  Map<String, dynamic> toJson() => _$ExampleLintConfigToJson(this);
}
