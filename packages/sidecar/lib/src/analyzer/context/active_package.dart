import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_config/package_config.dart';

import '../../configurations/configurations.dart';
import '../../protocol/protocol.dart';

part 'active_package.freezed.dart';
part 'active_package.g.dart';

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
    required Uri sidecarOptionsFile,
    required Uri sidecarPluginPackage,
    required List<Uri> sidecarPackages,
    required List<Uri> dependencies,
    List<Uri>? workspaceScope,
  }) = _ActivePackage;
  const ActivePackage._();

  factory ActivePackage.fromJson(Map<String, dynamic> json) =>
      _$ActivePackageFromJson(json);
}
