import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

import '../../../protocol/protocol.dart';
import '../../../services/services.dart';

final contextSidecarDependenciesProvider =
    Provider.family<List<RulePackageConfiguration>, ContextRoot>(
  (ref, root) {
    final service = ref.watch(activeProjectServiceProvider);
    return service.getSidecarDependencies(root.root.toUri());
  },
  name: 'contextSidecarDependenciesProvider',
  dependencies: [
    activeProjectServiceProvider,
  ],
);
