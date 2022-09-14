import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:source_span/source_span.dart';

import '../models/detected_lint.dart';
import '../models/lint_rule.dart';
import 'ast_utilities.dart';
import 'source_span_utilities.dart';

extension ElementX on Element {
  // SourceSpan toSourceSpan(ResolvedUnitResult unit) {
  //   final session = unit.session;

  //   final parsedLibResult =
  //       session.getParsedLibraryByElement(library!) as ParsedLibraryResult;

  //   final elDeclarationResult = parsedLibResult.getElementDeclaration(this);

  //   final node = elDeclarationResult?.node;
  //   final elementUnit = elDeclarationResult?.resolvedUnit;
  //   return node!.toSourceSpan(unit);
  // }

  // SourceRange toSourceRange(ResolvedUnitResult unit) {
  //   return toSourceSpan(unit).toSourceRange();
  // }

  // DetectedLint toDetectedLint(ResolvedUnitResult unit, LintRule rule) {
  //   return DetectedLint(rule: rule, unit: unit, sourceSpan: toSourceSpan(unit));
  // }
}

// extension ListElementX on List<Element> {
//   List<DetectedLint> toDetectedLints(ResolvedUnitResult unit, LintRule rule) {
//     return map((e) => e.toDetectedLint(unit, rule)).toList();
//   }
// }
