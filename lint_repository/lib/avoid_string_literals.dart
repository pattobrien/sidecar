// ignore_for_file: implementation_imports

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'package:source_span/source_span.dart';

import 'package:sidecar/sidecar.dart';

class AvoidStringLiterals extends LintError {
  AvoidStringLiterals(super.ref);

  @override
  String get code => 'avoid_string_literals';

  @override
  LintErrorType get defaultType => LintErrorType.info;

  @override
  String get message => '\${0} should be extracted to an ARB or ENV file.';

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
    final sourceSpan = reportedLintError.sourceSpan;

    final arbClassPrefix = 'AppLocalizations.of(context)';

    final stringNode = sourceSpan.toAstNode(unit);
    if (stringNode == null) return [];

    final stringElement = sourceSpan.toElement(unit);
    final references = <SourceSpan>[];
    if (stringNode.parent is VariableDeclaration && stringElement != null) {
      final analysisUtils = ref.read(analysisContextUtilitiesProvider);
      final refs = await analysisUtils.getReferences(unit, stringElement);
      references.addAll(refs);
    }

    final changeBuilder = ChangeBuilder(session: unit.session);
    await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
      final flutterRiverpodUri = Uri(
        scheme: 'package',
        path: 'localizations/localizations.dart',
      );

      fileBuilder.importLibraryElement(flutterRiverpodUri);

      Logger.logLine(
          'STRING LIT: ${stringNode.runtimeType} & PARENT: ${stringNode.parent.runtimeType}');
      if (stringNode.parent is VariableDeclaration) {
        Logger.logLine('VARIABLE DECL');
        fileBuilder.addDeletion(
          sourceSpan.toSourceRange(),
        );
      } else {
        Logger.logLine('NOT VARIABLE DECL');
        if (stringNode.isInsideBuildMethod()) {
          fileBuilder.addReplacement(
            sourceSpan.toSourceRange(),
            (editBuilder) => editBuilder.write(arbClassPrefix),
          );
        }
      }
    });

    for (final reference in references) {
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
    }

    final errorFixes = [
      PrioritizedSourceChange(
        0,
        changeBuilder.sourceChange..message = 'Replace declarations',
      ),
    ];
    return errorFixes;
  }
}

class _LiteralAstVisitor<R> extends GeneralizingAstVisitor<R> {
  _LiteralAstVisitor(this.lintRule);

  final LintError lintRule;

  @override
  R? visitStringLiteral(StringLiteral node) {
    if (node.parent is ImportDirective ||
        node is PartDirective ||
        node is PartOfDirective) {
      // node is part of import directive; skip
    } else {
      final parent = node.parent;
      final element = node.staticParameterElement;
      if (parent is VariableDeclaration) {
        // if the value is declared with a variable
        // then we need to handle it differently
        // (i.e. replace all references to variable)
        // lintRule.reportedAstNode(parent.name);
        lintRule.reportedAstNode(node);
      } else {
        lintRule.reportedAstNode(node);
      }
    }
    return super.visitStringLiteral(node);
  }
}
