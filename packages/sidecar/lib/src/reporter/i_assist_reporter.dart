import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import '../models/code_edit.dart';
import '../models/requested_code_edit.dart';

abstract class ICodeEditReporter {
  ICodeEditReporter(
    this.unit,
  );

  final ResolvedUnitResult unit;
  final List<RequestedCodeEdit> reportedEdits = <RequestedCodeEdit>[];

  void reportEdit(AstNode? node, CodeEdit edit);
}
