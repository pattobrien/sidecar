import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

import '../../../services/active_package_service.dart';
import '../../../services/plugin_generator/packages/sidecar_package.dart';

final contextSidecarDependenciesProvider =
    Provider.family<List<SidecarPackage>, ContextRoot>((ref, root) {
  final service = ref.watch(activePackageServiceProvider);
  return service.getSidecarDependencies(root.root.toUri());
});
