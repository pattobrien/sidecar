// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
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

  // @override
  // DetectedLint computeLintHighlight(DetectedLint lint) {}

  @override
  Future<List<PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) async {
    final unit = lint.unit;
    final lintedNode = lint.node;

    final changeBuilder = ChangeBuilder(session: unit.session);

    return [
      PrioritizedSourceChange(
        0,
        changeBuilder.sourceChange..message,
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
