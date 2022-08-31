import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/models/code_edit.dart';

import '../models/reported_lint_error.dart';
import '../models/lint_error.dart';
import '../ast/ast.dart';

abstract class ICodeEditReporter {
  ICodeEditReporter(
    this.unit,
  );

  final ResolvedUnitResult unit;
  final List<RequestedCodeEdit> reportedEdits = <RequestedCodeEdit>[];

  void reportEdit(AstNode? node, CodeEdit edit);
}
