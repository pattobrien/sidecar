import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_config/package_config_types.dart';

part 'active_package.freezed.dart';

@freezed

/// A representation of a sidecar-enabled Dart package.
///
/// Requirements for activating a package:
/// - add ```sidecar``` to the list of analyzer plugins in ```analysis_options.yaml```
/// - ```sidecar``` must be a dependency of the package
/// - ```sidecar.yaml``` file at root directory
class ActivePackage with _$ActivePackage {
  const factory ActivePackage({
    required Uri root,
    required PackageConfig packageConfig,
    List<Uri>? workspaceScope,
  }) = _ActivePackage;
  const ActivePackage._();
}
