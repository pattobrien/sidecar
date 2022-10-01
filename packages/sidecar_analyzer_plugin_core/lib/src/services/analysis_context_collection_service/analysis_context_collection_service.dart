import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

class AnalysisContextCollectionService {
  AnalysisContextCollectionService();

  late AnalysisContextCollection _collection;

  AnalysisContextCollection get collection => _collection;

  set collection(AnalysisContextCollection collection) {
    _collection = collection;
  }

  AnalysisContext getContextFromRoot(ContextRoot contextRoot) {
    return _collection.contexts
        .firstWhere((element) => element.contextRoot == contextRoot);
  }
}

final analysisContextCollectionServiceProvider =
    Provider<AnalysisContextCollectionService>((ref) {
  return AnalysisContextCollectionService();
});
