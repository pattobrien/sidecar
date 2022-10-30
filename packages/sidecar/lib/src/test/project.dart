import 'package:analyzer/file_system/file_system.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_config/package_config_types.dart';

import '../configurations/configurations.dart';

part 'project.freezed.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required Uri root,
    @Default(<File>[]) List<File> files,
    @Default(<Package>[]) List<Package> dependencies,
    @Default(<LintPackageConfiguration>[])
        List<LintPackageConfiguration> lintPackages,
    @Default(<AssistPackageConfiguration>[])
        List<AssistPackageConfiguration> assistPackages,
  }) = _Project;
  const Project._();
}
