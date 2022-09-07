import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class CodeEditReporter extends ICodeEditReporter {
  CodeEditReporter(super.unit);

  @override
  void reportEdit(AstNode? node, CodeEdit edit) {
    if (node != null) {
      final reportedLintError =
          RequestedCodeEdit(sourceUnit: unit, sourceNode: node, codeEdit: edit);
      reportedEdits.add(reportedLintError);
    }
  }
}
