import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../configurations/sidecar_spec/sidecar_spec.dart';
import '../../utils/file_paths.dart';
import 'active_package_provider.dart';
import 'plugin.dart';

final projectSidecarSpecProvider = Provider<SidecarSpec>((ref) {
  //TODO: listen to sidecar.yaml config file for changes via resourceProvider
  final activePackage = ref.watch(activePackageProvider);
  final sidecarYamlPath =
      p.join(activePackage.packageRoot.root.path, kSidecarYaml);
  final resource = ref.watch(analyzerResourceProvider).getFile(sidecarYamlPath);
  final sidecarSpec = parseSidecarSpecFromYaml(resource.readAsStringSync());
  // print('SIDECAR.YAML REFRESHING ${code.code} config');
  return sidecarSpec.item1;
});

final activeProjectIncludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.includes?.toSet() ?? SidecarSpec.defaultIncludes;
});

final activeProjectExcludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.excludes?.toSet() ?? SidecarSpec.defaultExcludes;
});
