import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:riverpod/riverpod.dart';

final allAnalysisContextsProvider = StateProvider<List<AnalysisContext>>(
  (ref) => [],
  name: 'allAnalysisContextsProvider',
  dependencies: const [],
);
