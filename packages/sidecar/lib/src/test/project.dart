import 'package:analyzer/file_system/file_system.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_config/package_config_types.dart';
import 'package:path/path.dart' as p;

import '../../sidecar.dart';
import '../configurations/configurations.dart';

part 'project.freezed.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String name,
    required Uri parent,
    required ResourceProvider resourceProvider,
    ProjectConfiguration? sidecarConfiguration,
    Map<String, String>? source,
    // @Default(<Package>[]) List<Package> dependencies,
  }) = _Project;

  const Project._();

  Folder get root => resourceProvider.getFolder(p.join(parent.path, name));
  File get packageConfig => getFile(p.join(kDartTool, kPackageConfigJson));

  File getFile(String relativePath) =>
      resourceProvider.getFile(p.join(root.path, relativePath));

  Folder getFolder(String relativePath) =>
      resourceProvider.getFolder(p.join(root.path, relativePath));

  File modifyFile(String relativePath, String content) {
    final file = getFile(p.join(root.path, relativePath));
    return file..writeAsStringSync(content);
  }

  File modifyAnalysisConfigYaml(String contents) {
    return modifyFile(kAnalysisOptionsYaml, contents);
  }

  File modifySidecarConfigYaml(ProjectConfiguration config) {
    final content = config.toYamlContent();
    return modifyFile(kSidecarYaml, content);
  }

  File modifyPackageConfigJson(PackageConfig config) {
    final content = PackageConfig.toJson(config);
    return modifyFile(kSidecarYaml, content.toString());
  }
}
