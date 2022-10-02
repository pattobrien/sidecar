import 'dart:async';

import 'package:analyzer/dart/analysis/session.dart';
import 'package:sidecar/builder.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';

class CreateTextEditControllerProvider extends CodeEdit {
  @override
  String get code => 'create_text_edit_controller_provider';

  @override
  String get packageName => 'riverpod_lints';

  @override
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) async {
    return [];
  }

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisSession session,
    AnalysisResult result,
  ) async {
    return result.maybeMap(
        orElse: () => [],
        dart: (_) async {
          final changeBuilder = ChangeBuilder(session: session);
          final unit =
              await session.getResolvedUnit(result.path) as ResolvedUnitResult;
          final node = result.sourceSpan.toAstNode(unit);

          if (node == null) return [];

          final parentNode = node.parent?.parent;

          if (parentNode is! NamedExpression) return [];

          final argumentOffset = parentNode.expression.beginToken.offset - 1;

          await changeBuilder.addDartFileEdit(
            unit.path,
            (builder) {
              builder.addInsertion(unit.unit.length, (builder) {
                builder.writeChangeNotifierProvider(
                  changeNotifier: 'TextEditingController()',
                  variableName: 'myTextControllerProvider',
                );
              });
              builder.addInsertion(argumentOffset, (builder) {
                builder.write('ref.watch(');
                builder.write('myTextControllerProvider');
                builder.write('), ');
              });
              builder.importFlutterRiverpod();
            },
          );

          return [
            EditResult(
              message: 'Declare a TextEditingController provider',
              sourceChanges: changeBuilder.sourceChange.edits,
            )
          ];
        });
  }
}
