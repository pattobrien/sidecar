import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../configurations/sidecar_spec/sidecar_spec.dart';
import '../../utils/file_paths.dart';
import '../analyzer_logger.dart';
import 'providers.dart';

final projectSidecarSpecProvider = Provider<SidecarSpec>((ref) {
  //TODO: listen to sidecar.yaml config file for changes via resourceProvider
  final logger = ref.watch(loggerProvider);
  final activePackage = ref.watch(activePackageProvider);
  final sidecarYamlPath = p.join(activePackage.root.toFilePath(), kSidecarYaml);
  final resource = ref.watch(analyzerResourceProvider).getFile(sidecarYamlPath);
  final sidecarSpec = parseSidecarSpec(resource.readAsStringSync());
  logger.info('SIDECAR SPEC: ${sidecarSpec.data.toJson()}');
  return sidecarSpec.data;
});

final activeProjectIncludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.includes?.toSet() ?? SidecarSpec.defaultIncludes;
});

final activeProjectExcludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.excludes?.toSet() ?? SidecarSpec.defaultExcludes;
});
