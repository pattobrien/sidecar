import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sidecar/sidecar.dart';

part 'project_configuration_state.freezed.dart';

@freezed
class ProjectConfigurationState with _$ProjectConfigurationState {
  const ProjectConfigurationState._();
  const factory ProjectConfigurationState({
    required ProjectConfiguration? configuration,
    @Default([]) List<YamlSourceError> errors,
  }) = _ProjectConfigurationState;
}
