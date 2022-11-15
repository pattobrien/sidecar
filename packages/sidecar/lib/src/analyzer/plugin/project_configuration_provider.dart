import 'package:riverpod/riverpod.dart';

import '../../configurations/configurations.dart';
import 'active_package_provider.dart';

final projectConfigurationProvider = Provider<ProjectConfiguration>((ref) {
  final activePackage = ref.watch(activePackageProvider);
  return activePackage.sidecarOptionsFile;
});

final activeProjectGlobSetProvider = Provider((ref) {
  final projectConfiguration = ref.watch(projectConfigurationProvider);
  return projectConfiguration.projectGlobs;
});
