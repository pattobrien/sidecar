import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';

import '../../utils/json_utils/json_utils.dart';
import 'package_options.dart';

part 'sidecar_spec.freezed.dart';
part 'sidecar_spec.g.dart';

@freezed
class SidecarSpec with _$SidecarSpec {
  const factory SidecarSpec({
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? includes,
    @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
        List<Glob>? excludes,
    Map<String, PackageOptions>? lints,
    Map<String, PackageOptions>? assists,
  }) = _SidecarSpec;

  const SidecarSpec._();

  factory SidecarSpec.fromJson(Map<String, dynamic> json) =>
      _$SidecarSpecFromJson(json);
}
