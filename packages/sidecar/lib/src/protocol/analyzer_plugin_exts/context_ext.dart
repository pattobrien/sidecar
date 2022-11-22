import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';

import '../analyzed_file.dart';

extension AnalysisContextXX on AnalysisContext {
  List<AnalyzedFile> typedAnalyzedFiles() => contextRoot.typedAnalyzedFiles();
}

extension ContextRootXX on ContextRoot {
  List<AnalyzedFile> typedAnalyzedFiles() => analyzedFiles()
      .map((e) => AnalyzedFile(Uri.parse(e), contextRoot: root.toUri()))
      .toList();
}
