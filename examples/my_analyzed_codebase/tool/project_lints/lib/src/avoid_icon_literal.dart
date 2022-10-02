// import 'dart:async';

// import 'package:analyzer/dart/element/element.dart';
// import 'package:sidecar/builder.dart';

// const _desc = r'Avoid IconData literal. Use design system spec instead.';

// class AvoidIconLiteral extends LintRule {
//   @override
//   String get code => 'avoid_icon_literal';

//   @override
//   String get packageName => 'design_system_lints';

//   final visitor = _SidecarVisitor();

//   @override
//   FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
//     ResolvedUnitResult unit,
//   ) async {
//     visitor.initializeVisitor(this, unit);
//     unit.unit.accept(visitor);
//     return visitor.nodes;
//   }

//   @override
//   Future<List<EditResult>> computeSourceChanges(AnalysisResult result) {
//     result as DartAnalysisResult;
//     visitor.initializeVisitor(result.rule, result.unit);
//     result.unit.unit.accept(visitor);
//     return super.computeSourceChanges(result);
//   }
// }

// class _SidecarVisitor extends SidecarAstVisitor {
//   @override
//   visitPrefixedIdentifier(PrefixedIdentifier node) {
//     final isIconData = _isIconData(node.prefix.staticElement);
//     if (isIconData) {
//       reportAstNode(node, message: _desc);
//     }
//     return super.visitPrefixedIdentifier(node);
//   }

//   bool _isIconData(Element? element) {
//     if (element != null) {
//       final iconDataPath = 'flutter/src/material/icons.dart';
//       final uri = element.librarySource?.uri;
//       if (uri == null) return false;
//       if (uri.isScheme('package') && uri.path == iconDataPath) {
//         return true;
//       }
//     }
//     return false;
//   }
// }

// class _Visitor extends GeneralizingAstVisitor {
//   _Visitor(this.rule, this.unit);
//   final List<DartAnalysisResult> nodes = [];
//   final SidecarBase rule;
//   final ResolvedUnitResult unit;

//   @override
//   visitPrefixedIdentifier(PrefixedIdentifier node) {
//     final isIconData = _isIconData(node.prefix.staticElement);
//     if (isIconData)
//       nodes.add(
//         node.toDartAnalysisResult(
//           rule,
//           unit: unit,
//           message: _desc,
//         ),
//       );
//     return super.visitPrefixedIdentifier(node);
//   }

//   bool _isIconData(Element? element) {
//     if (element != null) {
//       final iconDataPath = 'flutter/src/material/icons.dart';
//       final uri = element.librarySource?.uri;
//       if (uri == null) return false;
//       if (uri.isScheme('package') && uri.path == iconDataPath) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
