import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class CodeEditReporter extends ICodeEditReporter {
  CodeEditReporter(
    super.unit,
  );

  @override
  void reportEdit(AstNode? node, CodeEdit edit) {
    if (node != null) {
      final sourceSpan = node.toSourceSpan(unit);
      final reportedLintError = RequestedCodeEdit(
          sourceUnit: unit, selectedNode: node, codeEdit: edit);
      reportedEdits.add(reportedLintError);
    }
  }
}
