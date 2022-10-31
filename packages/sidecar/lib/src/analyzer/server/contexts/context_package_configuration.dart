import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

import '../../../configurations/configurations.dart';
import '../../../services/services.dart';

final projectConfigurationProvider =
    Provider.family<ProjectConfiguration?, ContextRoot>(
  (ref, contextRoot) {
    final packageService = ref.watch(activeProjectServiceProvider);
    return packageService.getSidecarOptions(contextRoot);
  },
  dependencies: [
    activeProjectServiceProvider,
  ],
);
