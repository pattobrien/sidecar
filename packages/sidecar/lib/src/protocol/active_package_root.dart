import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_package_root.freezed.dart';
part 'active_package_root.g.dart';

@freezed
class ActivePackageRoot with _$ActivePackageRoot {
  const factory ActivePackageRoot(
    Uri root,
  ) = _ActivePackageRoot;

  const ActivePackageRoot._();

  factory ActivePackageRoot.fromJson(Map<String, dynamic> json) =>
      _$ActivePackageRootFromJson(json);
}
