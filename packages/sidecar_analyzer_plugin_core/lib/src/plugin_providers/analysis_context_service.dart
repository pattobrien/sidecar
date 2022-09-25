import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

final analysisContextServiceProvider =
    Provider.family<AnalysisContextService, ContextRoot>(
        (ref, contextRoot) => AnalysisContextService(contextRoot));

class AnalysisContextService {
  AnalysisContextService(this.contextRoot);
  final ContextRoot contextRoot;
}
