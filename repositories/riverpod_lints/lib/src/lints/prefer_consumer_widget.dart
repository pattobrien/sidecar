// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';
import 'package:sidecar/sidecar.dart';

class PreferConsumerWidget extends LintRule {
  PreferConsumerWidget(super.ref);

  @override
  String get code => 'prefer_consumer_widget';

  @override
  String get packageName => 'riverpod_lints';

  @override
  String get message => 'Prefer to use ConsumerWidget.';

  @override
  void registerNodeProcessors(NodeLintRegistry registry) {
    final visitor = _Visitor<dynamic>(this);
    registry.addClassDeclaration(this, visitor);
  }

  @override
  DetectedLint computeLintHighlight(DetectedLint lint) {
    final node = lint.node;

    if (node is! ClassDeclaration) {
      return lint;
    } else {
      final superclass = node.extendsClause?.superclass;
      return lint.copyWith(highlightedNode: superclass);
    }
  }

  @override
  Future<List<PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) async {
    final unit = lint.unit;
    final lintedNode = lint.node;

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
  _Visitor(this.lintRule);

  final LintRule lintRule;

  @override
  R? visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause?.superclass.name;

    if (superclass?.name == 'StatelessWidget') {
      // lintRule.reportedAstNode(node.extendsClause?.superclass);
      lintRule.reportAstNode(node);
    }

    return super.visitClassDeclaration(node);
  }
}
