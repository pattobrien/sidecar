import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:sidecar/sidecar.dart';

class OutputAstNodeTree extends CodeEdit {
  @override
  String get code => 'output_ast_node_tree';

  @override
  String get packageName => 'sidecar_lints';

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisResult result,
  ) async {
    result as DartAnalysisResult;
    final session = result.unit.session;
    final unit = result.unit;
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
        message: 'Output AstNode info into a comment',
        sourceChanges: changeBuilder.sourceChange.edits,
      ),
    ];
  }
}
