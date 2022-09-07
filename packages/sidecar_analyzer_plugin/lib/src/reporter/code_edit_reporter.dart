import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class CodeEditReporter extends ICodeEditReporter {
  CodeEditReporter(super.unit);

  @override
  void reportEdit(AstNode? node, CodeEdit edit) {
    if (node != null) {
      final reportedCodeEdit =
          RequestedCodeEdit(sourceUnit: unit, sourceNode: node, codeEdit: edit);
      edit.computeSourceChange(reportedCodeEdit);
      reportedEdits.add(reportedCodeEdit);
    }
  }
}
