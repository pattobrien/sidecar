// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:sidecar/sidecar.dart';

// const kDesignSystemPackageId = 'intl_lints';
// const _kUrl = 'https://github.com/pattobrien/sidecar';
// final kUri = Uri.parse(_kUrl);

// final kStringLiteralsCode =
//     LintCode('string_literals', package: kDesignSystemPackageId, url: kUri);

// class StringLiterals extends SidecarAstVisitor with Lint, QuickFix {
//   @override
//   LintCode get code => kStringLiteralsCode;

//   @override
//   void initializeVisitor(NodeRegistry registry) {
//     registry.addSimpleStringLiteral(this);
//   }

//   @override
//   void visitStringLiteral(StringLiteral node) {
//     reportAstNode(node,
//         message: 'Avoid any hardcoded Strings.',
//         correction: 'Use an intl message instead.', editsComputer: () async {
//       return [
//         EditResult(message: 'Delete String', sourceChanges: [
//           SourceFileEdit(
//             filePath: unit.path,
//             edits: [
//               SourceEdit(
//                 originalSourceSpan: node.toSourceSpan(unit),
//                 replacement: 'replacement string',
//               ),
//             ],
//           ),
//         ]),
//       ];
//     });
//   }
// }
