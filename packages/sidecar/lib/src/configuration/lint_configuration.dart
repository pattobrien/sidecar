import 'package:freezed_annotation/freezed_annotation.dart';

part 'lint_configuration.freezed.dart';
part 'lint_configuration.g.dart';

@freezed
class LintConfiguration with _$LintConfiguration {
  const factory LintConfiguration({
    required String id,
    required bool enabled,
    required Map<dynamic, dynamic>? configuration,
  }) = _LintConfiguration;
  const LintConfiguration._();

  factory LintConfiguration.fromJson(Map json) =>
      _$LintConfigurationFromJson(json as Map<String, dynamic>);
}
