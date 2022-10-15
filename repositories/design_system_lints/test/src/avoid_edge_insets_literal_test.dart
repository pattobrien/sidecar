// import 'package:design_system_lints/design_system_lints.dart';
// import 'package:sidecar/test.dart';
// import 'package:test/test.dart';
// import 'dart:async';

// import 'package:flutter_utilities/flutter_utilities.dart';
// import 'package:sidecar/builder.dart';

// void main() {
//   test('test avoid edge insets visitor', () {
//     //

//     final results = testSidecarVisitor(
//       _Visitor(),
//       AvoidEdgeInsetsLiteral(),
//       content,
//     );
//     print(results.length);
//     final unit = testUnit(
//       _Visitor(),
//       AvoidEdgeInsetsLiteral(),
//       content,
//     );
//     print(unit.declarations.length);
//     unit.declarations.forEach((element) {
//       print(element.toSource());
//     });
//     final visitor = _Visitor();
//     unit.accept(visitor);
//     print('viis: ${visitor.results.length}');
//     visitor.results.forEach((element) {
//       print(element.beginToken);
//     });
//   });
// }

// final content = '''
// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: GlobalInsets.extraLarge,
//         vertical: 20,
//       ),
//     );
//   }
// }

// class GlobalInsets {
//   static const double xsmall = 4;
//   static const double small = 8;
//   static const double medium = 12;
//   static const double large = 16;
//   static const double extraLarge = 20;
// }


// ''';

// class _Visitor extends LintTestVisitor {
//   @override
//   void visitInstanceCreationExpression(InstanceCreationExpression node) {
//     final type = node.constructorName.staticElement?.returnType;
//     results.add(node);
//     if (FlutterTypeChecker.isEdgeInsets(type)) {
//       final args = node.argumentList.arguments
//           .whereType<NamedExpression>()
//           .where((e) =>
//               e.name.label.name == 'horizontal' ||
//               e.name.label.name == 'vertical');

//       for (var arg in args) {
//         final exp = arg.expression;
//         if (exp is DoubleLiteral || exp is IntegerLiteral) {
//           results.add(exp);
//         }
//         results.add(exp);
//         // e.g. CustomTheme.smallInsets()
//         if (exp is PrefixedIdentifier) {
//           //TODO: dart question: should we be going from AST => Element => AST
//           //to do this computation, or is there a way to do this via ASTs only?
//           // final ele = exp.staticElement!;
//           // final node = ele;
//           // final x = ele.canonicalElement;
//           //   final x =
//         }
//         // e.g. smallInsets()
//         if (exp is SimpleIdentifier) {
//           // final element = exp.staticElement;
//           // final x = element;

//         }
//       }
//     }
//     super.visitInstanceCreationExpression(node);
//   }
// }
