import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/protocol/analyzer_plugin_exts/source_exts.dart';

import 'constants.dart';

class OutputAstNodeTree extends SidecarAstVisitor with QuickAssist {
  @override
  AssistCode get code =>
      const AssistCode('output_ast_node_tree', package: kPackageName);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addNode(this);
    registry.addSimpleStringLiteral(this);
  }

  @override
  void visitNode(AstNode node) {
    reportAssistForNode(
      node,
      editsComputer: () => nodeChangeComputer(node),
    );
    super.visitNode(node);
  }

  @override
  void visitStringLiteral(StringLiteral node) {
    reportAssistForNode(
      node,
      editsComputer: () => nodeChangeComputer(node),
    );
  }

  Future<List<EditResult>> nodeChangeComputer(
    AstNode node,
  ) async {
    final changeBuilder = ChangeBuilder(session: unit.session);

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
        sourceChanges: changeBuilder.sourceChange.edits.fromPluginFileEdits(),
      ),
    ];
  }
}
