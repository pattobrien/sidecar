import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_configuration.freezed.dart';
part 'edit_configuration.g.dart';

@freezed
class EditConfiguration with _$EditConfiguration {
  const factory EditConfiguration({
    required String id,
    required bool enabled,
    required Map<dynamic, dynamic>? configuration,
  }) = _EditConfiguration;
  const EditConfiguration._();

  factory EditConfiguration.fromJson(Map<String, dynamic> json) =>
      _$EditConfigurationFromJson(json);
}
