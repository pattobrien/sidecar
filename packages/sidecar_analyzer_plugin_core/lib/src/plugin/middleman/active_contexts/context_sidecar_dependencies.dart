import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';

final contextSidecarDependenciesProvider =
    Provider.family<List<SidecarPackage>, ContextRoot>((ref, root) {
  final service = ref.watch(activePackageServiceProvider);
  return service.getSidecarDependencies(root.root.toUri());
});
