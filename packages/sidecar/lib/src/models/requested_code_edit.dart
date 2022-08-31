import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/models/code_edit.dart';
import 'package:source_span/source_span.dart';
import 'lint_error.dart';

import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;

import '../utils/source_span_utilities.dart';

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

  // plugin.AnalysisError toAnalysisError() {
  //   return plugin.AnalysisError(
  //     plugin.AnalysisErrorSeverity.INFO, // REPLACE WITH LINT ERROR
  //     plugin.AnalysisErrorType.LINT,
  //     sourceSpan.location,
  //     lint.message,
  //     lint.code,
  //   );
  // }
}
