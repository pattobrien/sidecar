import 'dart:async';

import 'package:collection/collection.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';
import 'package:sidecar/builder.dart';

class PreferConsumerWidget extends LintRule {
  @override
  String get code => 'prefer_consumer_widget';

  @override
  String get packageName => 'riverpod_lints';

  @override
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return visitor.nodes;
  }

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisResult result,
  ) async {
    final res = result as DartAnalysisResult;
    final unit = res.unit;
    final lintedNode = res.sourceSpan.toAstNode(unit);

    final changeBuilder = ChangeBuilder(session: unit.session);
    await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
      fileBuilder.importFlutterRiverpod();
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
      reportAstNode(
        superclass!,
        message: 'Prefer to use ConsumerWidget over StatelessWidget',
      );
    }

    return super.visitClassDeclaration(node);
  }
}
