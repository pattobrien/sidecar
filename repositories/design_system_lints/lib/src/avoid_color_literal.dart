import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;

import 'package:flutter_utilities/flutter_utilities.dart';

const _desc = r'Avoid color literal.';

class AvoidColorLiteral extends LintRule {
  AvoidColorLiteral(super.ref);

  @override
  String get code => 'avoid_color_literal';

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
    final rootDirectory = analysisContext.contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);
    final isIncluded = analysisContext.sidecarOptions.includes(relativePath);

    if (!isIncluded) return [];

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
    if (element != null &&
        element.isSameAs(uri: 'dart.ui', className: 'Color')) {
      nodes.add(node);
      // nodes.add(node.parent!.parent!);
    }
    super.visitInstanceCreationExpression(node);
  }
}
