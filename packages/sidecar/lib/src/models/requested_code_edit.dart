import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/models/code_edit.dart';

import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

class RequestedCodeEdit {
  RequestedCodeEdit({
    required this.codeEdit,
    required this.sourceUnit,
    required this.selectedNode,
  });

  final CodeEdit codeEdit;
  final ResolvedUnitResult sourceUnit;
  final AstNode selectedNode;

  Future<plugin.PrioritizedSourceChange> toPrioritizedSourceChanges(
    ProviderContainer ref,
  ) {
    return codeEdit.computeSourceChange(this);
  }
}
