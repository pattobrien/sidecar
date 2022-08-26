import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_span/source_span.dart';

import 'ast_utilities.dart';

extension ElementX on Element {
  SourceSpan toSourceSpan(ResolvedUnitResult unit) {
    final session = unit.session;

    final parsedLibResult =
        session.getParsedLibraryByElement(library!) as ParsedLibraryResult;

    final elDeclarationResult = parsedLibResult.getElementDeclaration(this);

    final node = elDeclarationResult?.node;
    return node!.toSourceSpan(unit);
  }
}
