import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';

final allContextsProvider = StateProvider<List<AnalysisContext>>(
  (ref) => [],
);

final activeContextsProvider = Provider<List<ActiveContext>>(
  (ref) {
    final activePackageService = ref.watch(activePackageServiceProvider);
    final allContexts = ref.watch(allContextsProvider);
    return allContexts.map(activePackageService.initializeContext).toList();
  },
  dependencies: [
    activePackageServiceProvider,
    allContextsProvider,
  ],
);

final activeContextRootsProvider = Provider<List<ActiveContextRoot>>(
  (ref) {
    return ref.watch(activeContextsProvider
        .select((value) => value.map((e) => e.activeRoot).toList()));
  },
  dependencies: [
    activeContextsProvider,
  ],
);

final activeContextForFileProvider =
    Provider.family<ActiveContext, AnalyzedFile>(
  (ref, file) {
    return ref.watch(activeContextsProvider.select((value) =>
        value.firstWhere((e) => e.activeRoot.isAnalyzed(file.path))));
  },
  dependencies: [
    activeContextsProvider,
  ],
);

final activeContextForContextRootProvider =
    Provider.family<ActiveContext, ActiveContextRoot>(
  (ref, root) {
    return ref.watch(activeContextsProvider
        .select((value) => value.firstWhere((e) => e.activeRoot == root)));
  },
  dependencies: [
    activeContextsProvider,
  ],
);
