// // ignore_for_file: implementation_imports
// import 'package:analyzer/dart/analysis/utilities.dart';
// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/ast/visitor.dart';

// import '../rules/base_rule_mixin.dart';

// String src = """
//   Dynamism d = new Dynamism(expert:true);
// main(){
//   var o = new Object();
//   d.on(o).hi = 'bye';
// }
// """;

// CompilationUnit testUnit(
//   LintTestVisitor visitor,
//   BaseRule rule,
//   String content,
// ) {
//   final ast = parseString(content: content);
//   return ast.unit;
// }

// List<AstNode> testSidecarVisitor(
//   LintTestVisitor visitor,
//   BaseRule rule,
//   String content,
//   // List<AnalysisResult> expectedResults,
// ) {
//   final ast = parseString(content: content);
//   ast.unit.accept<void>(visitor);
//   // print(ast.unit.lineInfo.lineCount);

//   // var verifiedResults = <AnalysisResult>[];
//   // for (var result in visitor.results) {
//   //   verifiedResults.add(
//   //     expectedResults.firstWhere((expectedResult) => expectedResult == result),
//   //   );
//   // }
//   return visitor.results;
// }

// class LintTestVisitor extends GeneralizingAstVisitor<void> {
//   List<AstNode> results = [];
// }
