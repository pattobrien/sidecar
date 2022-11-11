// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
// import 'package:sidecar/sidecar.dart';
// import 'package:source_span/source_span.dart';

// import 'constants.dart';

// class OutputSourceSpan extends AssistRule with AssistVisitor {
//   @override
//   String get code => 'output_source_span';

//   @override
//   String get packageName => kPackageName;

//   @override
//   Future<List<EditResult>> computeSourceChanges(
//     SourceSpan source,
//   ) async {
//     final unit = await getResolvedUnitResult(source.sourceUrl!.path);
//     final changeBuilder = ChangeBuilder(session: session);

//     final node = source.toAstNode(unit);
//     if (node == null) return [];
//     final sourceSpanString =
//         '// span(${node.offset}, ${node.offset + node.length}, \'${node.toSource()}\');';

//     await changeBuilder.addDartFileEdit(
//       unit.path,
//       (builder) => builder.addInsertion(
//         unit.unit.length,
//         (builder) => builder.writeln(sourceSpanString),
//       ),
//     );

//     return [
//       EditResult(
//         message: 'Output SourceSpan into a comment',
//         sourceChanges: changeBuilder.sourceChange.edits.fromPluginFileEdits(),
//       ),
//     ];
//   }

//   @override
//   SidecarAssistVisitor Function() get visitorCreator => _Visitor.new;
// }

// class _Visitor extends SidecarAssistVisitor {
//   @override
//   void visitNode(AstNode node) {
//     // node.visitChildren(this);
//     // reportAstNode(node);
//   }
// }
