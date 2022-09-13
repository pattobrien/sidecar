// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/analysis/analysis_context.dart';
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
    final rootDirectory = analysisContext.contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);
    final isIncluded = analysisContext.sidecarOptions.includes(relativePath);

    if (!isIncluded) return [];

    final unit = await analysisContext.currentSession.getResolvedUnit(path);
    if (unit is! ResolvedUnitResult) return [];
    return [];
  }

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
