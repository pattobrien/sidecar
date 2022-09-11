// ignore_for_file: implementation_imports

import 'package:sidecar/sidecar.dart';
import 'package:flutter_utilities/flutter_utilities.dart';

class AvoidStringLiterals extends LintError {
  AvoidStringLiterals(super.ref);

  @override
  String get code => 'avoid_string_literals';

  @override
  String get message => '\${STRING} should be extracted to an ARB or ENV file.';

  @override
  String get packageName => 'l10n_lints';

  @override
  LintErrorType get defaultType => LintErrorType.info;

  @override
  void registerNodeProcessors(NodeLintRegistry registry) {
    final visitor = _LiteralAstVisitor(this);
    registry.addSimpleStringLiteral(this, visitor);
  }

  @override
  Future<List<PrioritizedSourceChange>> computeFixes(
    ReportedLintError reportedLintError,
  ) async {
    final unit = reportedLintError.sourceUnit;
    final stringNode = reportedLintError.reportedNode;

    final changeBuilder = ChangeBuilder(session: unit.session);

    final flutterLocalizationsGenUri = Uri(
      scheme: 'package',
      path: 'flutter_gen/gen_l10n/app_localizations.dart',
    );

    final computedStringId = 'string123';

    final arbClassPrefix = 'AppLocalizations.of(context).$computedStringId';

    final references = <SourceSpan>[];
    final parentNode = stringNode.parent;
    if (parentNode is VariableDeclaration) {
      final element = parentNode.declaredElement2;
      if (element != null) {
        final analysisUtils = ref.read(analysisContextUtilitiesProvider);
        final refs = await analysisUtils.getReferences(unit, element);
        references.addAll(refs);
      }
    }

    // we dont want to replace a string if not every variable reference
    // will have access to it
    final areAllReferencesWithinBuildMethods = references.every((reference) {
      final node = reference.toAstNode(unit);
      return node!.isInsideBuildMethod();
    });

    if (areAllReferencesWithinBuildMethods && references.isNotEmpty) {
      final expression = stringNode.parent?.parent?.parent;
      await changeBuilder.addDartFileEdit(unit.path, (builder) {
        builder.importLibraryElement(flutterLocalizationsGenUri);
        builder.addDeletion(
          expression!.toSourceSpan(unit).toSourceRange(),
        );
      });

      await Future.wait(references.map((reference) async {
        final node = reference.toAstNode(unit);
        if (node!.isInsideBuildMethod()) {
          await changeBuilder.addDartFileEdit(
            reference.sourceUrl!.path,
            (fileBuilder) => fileBuilder.addReplacement(
              reference.toSourceRange(),
              (editBuilder) => editBuilder.write(arbClassPrefix),
            ),
          );
        }
      }));
    }

    if (parentNode is ArgumentList) {
      await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
        if (stringNode.isInsideBuildMethod()) {
          fileBuilder.importLibraryElement(flutterLocalizationsGenUri);
          fileBuilder.addReplacement(
            stringNode.toSourceRange(unit),
            (editBuilder) => editBuilder.write(arbClassPrefix),
          );
        } else {
          // offer no quick fix
        }
      });
    }
    if (changeBuilder.sourceChange.edits.isNotEmpty) {
      final errorFixes = [
        PrioritizedSourceChange(
          0,
          changeBuilder.sourceChange..message = 'Extract string declaration',
        ),
      ];
      return errorFixes;
    } else {
      return [];
    }
  }
}

class _LiteralAstVisitor<R> extends GeneralizingAstVisitor<R> {
  _LiteralAstVisitor(this.lintRule);

  final LintError lintRule;

  @override
  R? visitStringLiteral(StringLiteral node) {
    if (node.parent is! ImportDirective &&
        node is! PartDirective &&
        node is! PartOfDirective) {
      lintRule.reportedAstNode(node);
    }

    return super.visitStringLiteral(node);
  }
}
