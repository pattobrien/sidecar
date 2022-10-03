// import 'package:analyzer/dart/analysis/results.dart';
// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/ast/token.dart';

// import '../models/models.dart';
// import '../utils/utils.dart';
// import 'sidecar_ast_visitor.dart';

// abstract class SidecarAstVisitorImpl extends SidecarAstVisitor {
//   @override
//   void initializeVisitor(
//     SidecarBase rule,
//     ResolvedUnitResult unit, [
//     List<AnnotatedNode> annotatedNodes = const [],
//   ]) {
//     this.unit = unit;
//     this.rule = rule;
//     this.annotatedNodes = annotatedNodes;
//   }

//   @override
//   void reportAstNode(
//     AstNode node, {
//     required String message,
//     String? correction,
//   }) {
//     final result = DartAnalysisResult(
//       unit: unit,
//       rule: rule,
//       sourceSpan: node.toSourceSpan(unit),
//       message: message,
//       correction: correction,
//     );
//     nodes.add(result);
//   }

//   @override
//   void reportToken(
//     Token token, {
//     required String message,
//     String? correction,
//   }) {
//     final result = DartAnalysisResult(
//       unit: unit,
//       rule: rule,
//       sourceSpan: token.toSourceSpan(unit),
//       message: message,
//       correction: correction,
//     );
//     nodes.add(result);
//   }
// }
