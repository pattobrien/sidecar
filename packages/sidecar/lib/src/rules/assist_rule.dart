import 'package:analyzer/dart/analysis/results.dart';
import 'package:source_span/source_span.dart';

import '../protocol/protocol.dart';
import 'analysis_source.dart';
import 'base_rule.dart';
import 'sidecar_ast_visitor.dart';

abstract class AssistRule extends BaseRule {
  // TODO: need to figure out the correct API to design for here.
  // users should be able to easily filter out the types of AstNodes they want
  // without having to re-check its type in the computeSourceChanges phase
  Future<List<AssistResult>> filterResults(ResolvedUnitResult unit);

  Future<List<EditResult>> computeSourceChanges(SourceSpan source);
}

mixin AssistVisitor on AssistRule {
  SidecarAssistVisitor Function() get visitorCreator;

  @override
  Future<List<AssistResult>> filterResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = visitorCreator();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.assists);
  }
}
