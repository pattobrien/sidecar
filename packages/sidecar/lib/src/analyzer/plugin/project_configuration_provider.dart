import 'package:riverpod/riverpod.dart';

import '../../configurations/configurations.dart';
import '../../services/active_project_service.dart';
import 'active_package_provider.dart';

final projectConfigurationProvider = Provider<ProjectConfiguration>((ref) {
  final activePackage = ref.watch(activePackageProvider).valueOrNull;
  final packageService = ref.watch(activeProjectServiceProvider);
  final root = activePackage!.packageRoot.root;
  return packageService.getSidecarOptions(root)!;
});

final activeProjectGlobSetProvider = Provider((ref) {
  final projectConfiguration = ref.watch(projectConfigurationProvider);
  return projectConfiguration.projectGlobs;
});
