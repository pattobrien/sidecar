import 'package:sidecar/builder.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';

class CreateTextEditControllerProvider extends CodeEdit {
  @override
  String get code => 'create_text_edit_controller_provider';

  @override
  String get packageName => 'riverpod_lints';

  @override
  Future<List<PrioritizedSourceChange>> computeDartSourceChanges(
    DartAnalysisResult result,
  ) async {
    final session = result.unit.session;
    final unit = result.unit;
    final changeBuilder = ChangeBuilder(session: session);

    final node = result.sourceSpan.toAstNode(unit);

    if (node == null) return [];

    final parentNode = node.parent?.parent;

    if (parentNode is! NamedExpression) return [];

    final argumentOffset = parentNode.expression.beginToken.offset - 1;

    await changeBuilder.addDartFileEdit(
      result.unit.path,
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
      PrioritizedSourceChange(
        0,
        changeBuilder.sourceChange
          ..message = 'Declare a TextEditingController provider',
      )
    ];
  }
}
