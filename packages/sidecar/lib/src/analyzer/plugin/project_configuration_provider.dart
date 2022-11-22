import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import '../../configurations/sidecar_spec/sidecar_spec_base.dart';
import 'active_package_provider.dart';

final projectSidecarSpecProvider = Provider<SidecarSpec>((ref) {
  final activePackage = ref.watch(activePackageProvider);
  return activePackage.sidecarSpec;
});

final activeProjectIncludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.includes?.toSet() ?? SidecarSpec.defaultIncludes;
});

final activeProjectExcludeGlobsProvider = Provider<Set<Glob>>((ref) {
  final projectConfiguration = ref.watch(projectSidecarSpecProvider);
  return projectConfiguration.excludes?.toSet() ?? SidecarSpec.defaultExcludes;
});
