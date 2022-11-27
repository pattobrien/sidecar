import 'package:analyzer/file_system/file_system.dart';
// import 'package:analyzer/src/context/packages.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../configurations/sidecar_spec/sidecar_spec_base.dart';
import 'project.dart';

part 'project_notifier.g.dart';

@riverpod
class ProjectNotifier extends _$ProjectNotifier {
  @override
  Project build(
    String name,
    Folder folder, {
    SidecarSpec? sidecarConfiguration,
    Map<String, String>? source,
  }) {
    // create project
    final project = Project(
      name: name,
      parent: folder.toUri(),
      resourceProvider: folder.provider,
      sidecarConfiguration: sidecarConfiguration,
      source: source,
    );
    // create package_config.json file
    // final packageFile = project.packageConfig;
    // final packages = parsePackageConfigJsonFile(folder.provider, packageFile);
    return project;
  }

  void addDependency(Folder folder) {
    //
  }

  void addLintPackage(Folder folder) {
    //
  }
}
