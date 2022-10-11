import 'package:analyzer/dart/analysis/context_root.dart';

import '../analyzed_file/analyzed_file.dart';

extension ContextRootX on ContextRoot {
  List<AnalyzedFile> typedAnalyzedFiles() =>
      analyzedFiles().map((e) => AnalyzedFile(this, e)).toList();
}
