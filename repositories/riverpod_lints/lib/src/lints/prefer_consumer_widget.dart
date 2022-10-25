import 'dart:async';

import 'package:analyzer/dart/analysis/session.dart';
import 'package:collection/collection.dart';
import 'package:sidecar/builder.dart';

class PreferConsumerWidget extends LintRule {
  @override
  String get code => 'prefer_consumer_widget';

  @override
  String get packageName => 'riverpod_lints';

  @override
  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return Future.value(visitor.nodes);
  }

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisResult result,
  ) async {
    // final x = RiverpodTypes
    final unit =
        await session.getResolvedUnit(result.path) as ResolvedUnitResult;
    final lintedNode = result.sourceSpan.toAstNode(unit);

    final changeBuilder = ChangeBuilder(session: session);
    await changeBuilder.addDartFileEdit(result.path, (fileBuilder) {
      // fileBuilder.importFlutterRiverpod();
      if (lintedNode is ClassDeclaration) {
        final superClass = lintedNode.extendsClause!.superclass;

        fileBuilder.addReplacement(
          superClass.toSourceRange(unit),
          (builder) => builder.write('ConsumerWidget'),
        );

        final buildFunction = lintedNode.members
            .whereType<MethodDeclaration>()
            .firstWhereOrNull((method) => method.name2.lexeme == 'build');

        final paramOffset = buildFunction?.parameters?.rightParenthesis.offset;
        if (paramOffset != null) {
          fileBuilder.addInsertion(
            paramOffset,
            (builder) => builder.write(', WidgetRef ref'),
          );
        }
      }
    });

    return [
      EditResult(
        analysisResult: result,
        message: 'Replace with ConsumerWidget',
        sourceChanges: changeBuilder.sourceChange.edits,
      ),
    ];
  }
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause?.superclass;

    if (superclass?.name.name == 'StatelessWidget') {
      reportToken(
        node.name2,
        message: 'Prefer to use ConsumerWidget over StatelessWidget',
      );
    }

    return super.visitClassDeclaration(node);
  }
}
