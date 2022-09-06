import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:source_span/source_span.dart';

import 'ast_utilities.dart';
import 'source_span_utilities.dart';

extension ElementX on Element {
  SourceSpan toSourceSpan(ResolvedUnitResult unit) {
    final session = unit.session;

    final parsedLibResult =
        session.getParsedLibraryByElement(library!) as ParsedLibraryResult;

    final elDeclarationResult = parsedLibResult.getElementDeclaration(this);

    final node = elDeclarationResult?.node;
    return node!.toSourceSpan(unit);
  }

  SourceRange toSourceRange(ResolvedUnitResult unit) {
    return toSourceSpan(unit).toSourceRange();
  }
}
