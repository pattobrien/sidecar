import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/protocol/analyzer_plugin_exts/source_exts.dart';

import 'constants.dart';

class OutputSourceSpan extends Rule with QuickAssist {
  @override
  RuleCode get code =>
      const AssistCode('output_source_span', package: kPackageName);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addNode(this);
  }

  @override
  void visitNode(AstNode node) {
    reportAssistForNode(
      node,
      message: 'message',
      editsComputer: () async {
        final changeBuilder = ChangeBuilder(session: unit.session);

        final sourceSpanString =
            "// span(${node.offset}, ${node.offset + node.length}, '${node.toSource()}');";

        await changeBuilder.addDartFileEdit(
          unit.path,
          (builder) => builder.addInsertion(
            unit.unit.length,
            (builder) => builder.writeln(sourceSpanString),
          ),
        );

        return [
          EditResult(
            message: 'Output SourceSpan into a comment',
            sourceChanges:
                changeBuilder.sourceChange.edits.fromPluginFileEdits(),
          ),
        ];
      },
    );
  }
}
