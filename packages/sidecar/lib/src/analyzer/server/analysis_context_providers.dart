import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import '../../utils/logger/logger.dart';

/// All valid and invalid contexts, managed by the middleman plugin.
final allContextsProvider = StateProvider<List<AnalysisContext>>(
  (ref) => [],
  name: 'allContextsProvider',
);

/// All valid and invalid context roots.
final allContextRootsProvider = Provider<List<ContextRoot>>(
  (ref) {
    final contextRoots = ref.watch(allContextsProvider.select(
      (contexts) => contexts.map((context) => context.contextRoot).toList(),
    ));
    logger.finer('MM # of all contexts => ${contextRoots.length} ');
    return contextRoots;
  },
  name: 'allContextRootsProvider',
  dependencies: [
    allContextsProvider,
  ],
);
