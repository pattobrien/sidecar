// import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
// import 'package:riverpod/riverpod.dart';

// final analysisContextCollectionProvider =
//     StateProvider<AnalysisContextCollection?>((ref) => null);

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:riverpod/riverpod.dart';

final analysisContextsProvider = StateProvider(
  (ref) => <AnalysisContext>[],
  dependencies: const [],
);
