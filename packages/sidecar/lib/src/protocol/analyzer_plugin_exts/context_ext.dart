import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';

import '../../analyzer/context/analyzed_file.dart';
import '../protocol.dart';

extension AnalysisContextXX on AnalysisContext {
  List<AnalyzedFile> typedAnalyzedFiles() => contextRoot.typedAnalyzedFiles();
}

extension ContextRootXX on ContextRoot {
  List<AnalyzedFile> typedAnalyzedFiles() => analyzedFiles()
      .map((e) => AnalyzedFile(Context(root: root.toUri()), Uri.parse(e)))
      .toList();
}
