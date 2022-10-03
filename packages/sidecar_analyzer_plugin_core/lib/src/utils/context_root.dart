import 'package:analyzer/dart/analysis/context_root.dart';

import '../context_services/context_services.dart';

extension ContextRootX on ContextRoot {
  List<AnalyzedFile> typedAnalyzedFiles() =>
      analyzedFiles().map((e) => AnalyzedFile(this, e)).toList();
}
