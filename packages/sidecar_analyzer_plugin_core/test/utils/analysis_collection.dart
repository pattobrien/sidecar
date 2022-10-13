import 'package:analyzer/dart/analysis/analysis_context_collection.dart';

AnalysisContextCollection createTestableCollectionForPath(String root) {
  return AnalysisContextCollection(
    includedPaths: [root],
    // excludedPaths: ,
    // resourceProvider: ,
    // sdkPath: ,
  );
}
