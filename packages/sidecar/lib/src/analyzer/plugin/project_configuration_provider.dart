import 'package:riverpod/riverpod.dart';

import '../../configurations/configurations.dart';
import '../../services/active_project_service.dart';
import 'active_package_provider.dart';

final projectConfigurationProvider = Provider<ProjectConfiguration>((ref) {
  final activePackage = ref.watch(activePackageProvider).value!;
  final activePackageService = ref.watch(activeProjectServiceProvider);
  return activePackageService.getSidecarOptions(activePackage.root)!;
});

final activeProjectGlobSetProvider = Provider((ref) {
  final projectConfiguration = ref.watch(projectConfigurationProvider);
  return projectConfiguration.projectGlobs;
});
