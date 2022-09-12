import 'package:sidecar/sidecar.dart';

class OutputAstNodeTree extends CodeEdit {
  OutputAstNodeTree(super.ref);

  @override
  String get code => 'output_ast_node_tree';

  @override
  String get packageName => 'sidecar_lints';

  @override
  Future<PrioritizedSourceChange?> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    final session = requestedCodeEdit.unit.session;
    final unit = requestedCodeEdit.unit;
    final changeBuilder = ChangeBuilder(session: session);

    final node = requestedCodeEdit.node;

    await changeBuilder.addDartFileEdit(
      requestedCodeEdit.unit.path,
      (builder) {
        builder.addInsertion(
          unit.unit.length,
          (builder) {
            builder.write(
                '\n// (node => parents): ${node.runtimeType} => ${node.parent.runtimeType} => ${node.parent?.parent.runtimeType} => ${node.parent?.parent?.parent.runtimeType}\n');
          },
        );
      },
    );
    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange..message = 'Output AstNode and parents.',
    );
  }
}
