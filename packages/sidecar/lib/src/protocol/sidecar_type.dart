import 'package:freezed_annotation/freezed_annotation.dart';

part 'sidecar_type.freezed.dart';

@freezed
class SidecarType with _$SidecarType {
  const factory SidecarType({
    required String typeName,
    required String packageName,
    required String packagePath,
  }) = _SidecarType;
  const SidecarType._();
}
