import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

part 'lint_configuration.g.dart';

@JsonSerializable(anyMap: true)
class LintConfiguration {
  const LintConfiguration({
    required this.packageName,
    required this.lintId,
    this.enabled = true,
    required this.configuration,
  });

  final String packageName;
  final String lintId;
  final bool enabled;
  final Map<dynamic, dynamic> configuration;

  factory LintConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LintConfigurationFromJson(json);
}

extension LintConfigurationX on LintConfiguration {
  String get filePath => '$packageName/$packageName.dart';
  String get className => ReCase(lintId).pascalCase;
}
