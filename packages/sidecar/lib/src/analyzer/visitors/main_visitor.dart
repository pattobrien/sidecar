// import 'dart:async';

// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/ast/visitor.dart';

// class MainVisitor extends GeneralizingAstVisitor<void> {
//   Stream<AstNode> get nodeVisits => _controller.stream;
//   void Function(AstNode node) onNode;
//   final _controller = StreamController<AstNode>();

//   @override
//   void visitForStatement(ForStatement node) {
//     super.visitForStatement(node);
//   }

//   @override
//   void visitFunctionBody(FunctionBody node) {
//     super.visitFunctionBody(node);
//   }

//   void dispose() {
//     _controller.close();
//   }
// }
// // when sidecar is initialized: subscribe all rules to the streams they want
// // on every file edit, resolve the ast structure
// // then refresh analysis errors for that file

// void doSomething(CompilationUnit unit) {
//   final visitor = MainVisitor();
//   visitor.nodeVisits.listen((event) {
//     //
//   });
//   unit.accept<void>(visitor);
// }
