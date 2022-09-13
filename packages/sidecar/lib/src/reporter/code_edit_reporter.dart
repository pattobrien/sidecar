import 'package:analyzer/dart/ast/ast.dart';

import '../models/models.dart';
import 'reporter.dart';

class CodeEditReporter extends ICodeEditReporter {
  CodeEditReporter(super.unit);

  @override
  void reportAstNode(AstNode? node, CodeEdit edit) {
    if (node != null) {
      final reportedCodeEdit =
          RequestedCodeEdit(unit: unit, node: node, codeEdit: edit);
      edit.computeSourceChange(reportedCodeEdit);
      reportedEdits.add(reportedCodeEdit);
    }
  }
}
