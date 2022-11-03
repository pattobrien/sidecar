import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class OutputAstNodeTree extends AssistRule with AssistVisitor {
  @override
  String get code => 'output_ast_node_tree';

  @override
  String get packageName => kPackageName;

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisSource source,
  ) async {
    // final unit = await getResolvedUnitResult(source.path);
    // final changeBuilder = ChangeBuilder(session: session);

    // final node = source.mapOrNull(span: (span) => span.source)?.toAstNode(unit);
    // if (node == null) return [];

    // await changeBuilder.addDartFileEdit(
    //   unit.path,
    //   (builder) {
    //     builder.addInsertion(
    //       unit.unit.length,
    //       (builder) {
    //         builder.write(
    //             '\n// ${node.beginToken} (node => parents): ${node.runtimeType} => ${node.parent.runtimeType} => ${node.parent?.parent.runtimeType} => ${node.parent?.parent?.parent.runtimeType}\n');
    //       },
    //     );
    //   },
    // );
    return [
      // EditResult(
      //   message: 'Output AstNode info into a comment',
      //   sourceChanges: changeBuilder.sourceChange.edits,
      // ),
    ];
  }

  @override
  SidecarAssistVisitor Function() get visitorCreator => _Visitor.new;
}

class _Visitor extends SidecarAssistVisitor {
  @override
  void visitNode(AstNode node) {
    // node.visitChildren(this);
    // reportAstNode(node);
  }
}
