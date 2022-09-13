// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/analysis/results.dart';
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

  // @override
  // void registerNodeProcessors(NodeLintRegistry registry) {
  //   final visitor = _Visitor<dynamic>(this);
  //   registry.addClassDeclaration(this, visitor);
  // }

  // @override
  // DetectedLint computeLintHighlight(DetectedLint lint) {}
  @override
  List<DetectedLint> computeAnalysisError(ResolvedUnitResult unit) => [];

  @override
  Future<List<PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) async {
    final unit = lint.unit;
    final lintedNode = lint.sourceSpan.toAstNode(unit);

    final changeBuilder = ChangeBuilder(session: unit.session);

    return [
      PrioritizedSourceChange(
        0,
        changeBuilder.sourceChange..message,
      ),
    ];
  }
}
