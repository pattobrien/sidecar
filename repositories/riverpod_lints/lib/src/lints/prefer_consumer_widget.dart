// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';
import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;

class PreferConsumerWidget extends LintRule {
  PreferConsumerWidget(super.ref);

  @override
  String get code => 'prefer_consumer_widget';

  @override
  String get packageName => 'riverpod_lints';

  @override
  String get message => 'Prefer to use ConsumerWidget.';

  @override
  Future<List<DetectedLint>> computeAnalysisError(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final visitor = _Visitor<dynamic>();
    final rootDirectory = analysisContext.contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);
    final isIncluded = analysisContext.sidecarOptions.includes(relativePath);

    if (!isIncluded) return [];
    final unit = await analysisContext.currentSession.getResolvedUnit(path);
    if (unit is! ResolvedUnitResult) return [];
    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this);
  }

  @override
  SourceSpan computeLintHighlight(DetectedLint lint) {
    final node = lint.sourceSpan.toAstNode(lint.unit);

    if (node is! ClassDeclaration) {
      return lint.sourceSpan;
    } else {
      final superclass = node.extendsClause?.superclass;

      if (superclass == null) return lint.sourceSpan;

      return superclass.toSourceSpan(lint.unit);
    }
  }

  @override
  Future<List<PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) async {
    final unit = lint.unit;
    final lintedNode = lint.sourceSpan.toAstNode(unit);

    final changeBuilder = ChangeBuilder(session: unit.session);
    await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
      fileBuilder.importFlutterRiverpod();
      if (lintedNode is ClassDeclaration) {
        final superClass = lintedNode.extendsClause!.superclass;

        fileBuilder.addReplacement(
          superClass.toSourceRange(unit),
          (builder) => builder.write('ConsumerWidget'),
        );

        final buildFunction = lintedNode.members
            .whereType<MethodDeclaration>()
            .firstWhereOrNull(
                (method) => method.name2.value().toString() == 'build');

        final paramOffset = buildFunction?.parameters?.rightParenthesis.offset;
        if (paramOffset != null) {
          fileBuilder.addInsertion(
            paramOffset,
            (builder) => builder.write(', WidgetRef ref'),
          );
        }
      }
    });

    return [
      PrioritizedSourceChange(
        0,
        changeBuilder.sourceChange..message = 'Replace with ConsumerWidget',
      ),
    ];
  }
}

class _Visitor<R> extends GeneralizingAstVisitor<R> {
  _Visitor();

  final List<AstNode> nodes = [];

  @override
  R? visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause?.superclass.name;

    if (superclass?.name == 'StatelessWidget') {
      // lintRule.reportedAstNode(node.extendsClause?.superclass);
      nodes.add(node.extendsClause!.superclass);
    }

    return super.visitClassDeclaration(node);
  }
}
