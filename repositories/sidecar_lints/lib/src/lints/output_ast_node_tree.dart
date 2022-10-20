import 'package:analyzer/dart/analysis/session.dart';
import 'package:sidecar/builder.dart';

class OutputAstNodeTree extends CodeEdit {
  @override
  String get code => 'output_ast_node_tree';

  @override
  String get packageName => 'sidecar_lints';

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisResult result,
  ) async {
    result as DartAnalysisResult;
    final unit =
        await session.getResolvedUnit(result.path) as ResolvedUnitResult;
    final changeBuilder = ChangeBuilder(session: session);

    final node = result.sourceSpan.toAstNode(unit);
    if (node == null) return [];

    await changeBuilder.addDartFileEdit(
      unit.path,
      (builder) {
        builder.addInsertion(
          unit.unit.length,
          (builder) {
            builder.write(
                '\n// ${node.beginToken} (node => parents): ${node.runtimeType} => ${node.parent.runtimeType} => ${node.parent?.parent.runtimeType} => ${node.parent?.parent?.parent.runtimeType}\n');
          },
        );
      },
    );
    return [
      EditResult(
        analysisResult: result,
        message: 'Output AstNode info into a comment',
        sourceChanges: changeBuilder.sourceChange.edits,
      ),
    ];
  }
}
