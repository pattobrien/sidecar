import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

/// All valid and invalid contexts, managed by the middleman plugin.
final allContextsProvider = StateProvider<List<AnalysisContext>>((ref) => []);

/// All valid and invalid context roots.
final allContextRootsProvider = Provider<List<ContextRoot>>(
  (ref) {
    return ref.watch(allContextsProvider).map((e) => e.contextRoot).toList();
  },
  dependencies: [
    allContextsProvider,
  ],
);
