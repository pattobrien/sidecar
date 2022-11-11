import 'package:riverpod/riverpod.dart';

import '../../services/active_project_service.dart';
import 'analysis_contexts_provider.dart';

final projectConfigurationProvider = Provider((ref) {
  final activeProjectService = ref.watch(activeProjectServiceProvider);
  final activeProjectRoot = ref.watch(rootUriProvider);
  return activeProjectService.getSidecarOptions(activeProjectRoot)!;
});

final activeProjectGlobSetProvider = Provider((ref) {
  final projectConfiguration = ref.watch(projectConfigurationProvider);
  return projectConfiguration.projectGlobs;
});
