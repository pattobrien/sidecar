import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import 'code_edit.dart';

class RequestedCodeEdit {
  RequestedCodeEdit({
    required this.codeEdit,
    required this.unit,
    required this.node,
  });

  final CodeEdit codeEdit;
  final ResolvedUnitResult unit;
  final AstNode node;

  Future<plugin.PrioritizedSourceChange?> toPrioritizedSourceChange(
    Ref ref,
  ) {
    return codeEdit.computeSourceChange(this);
  }
}
