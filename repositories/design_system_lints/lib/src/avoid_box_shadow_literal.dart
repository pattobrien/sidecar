import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;

const _desc = r'Avoid BoxShadow literal.';

class AvoidBoxShadowLiteral extends LintRule {
  AvoidBoxShadowLiteral(super.ref);

  @override
  String get code => 'avoid_box_shadow_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  String get message => _desc;

  @override
  Future<List<DetectedLint>> computeAnalysisError(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final visitor = _Visitor();

    final unit = await analysisContext.currentSession.getResolvedUnit(path);
    if (unit is! ResolvedUnitResult) return [];

    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this);
  }

  @override
  SourceSpan computeLintHighlight(DetectedLint lint) {
    return lint.sourceSpan;
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (element != null && element.returnType.element2.name == 'BoxShadow') {
      nodes.add(node);
    }
    super.visitInstanceCreationExpression(node);
  }
}
