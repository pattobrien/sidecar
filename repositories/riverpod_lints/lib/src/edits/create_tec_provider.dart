import 'package:sidecar/sidecar.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';

class CreateTextEditControllerProvider extends CodeEdit {
  CreateTextEditControllerProvider(super.ref);

  @override
  String get code => 'create_text_edit_controller_provider';

  @override
  String get packageName => 'riverpod_lints';

  @override
  Future<PrioritizedSourceChange?> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    final session = requestedCodeEdit.unit.session;
    final unit = requestedCodeEdit.unit;
    final changeBuilder = ChangeBuilder(session: session);

    final node = requestedCodeEdit.node;
    final parentNode = node.parent?.parent;

    if (parentNode is! NamedExpression) return null;

    final argumentOffset = parentNode.expression.beginToken.offset - 1;

    await changeBuilder.addDartFileEdit(
      requestedCodeEdit.unit.path,
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

    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange
        ..message = 'Declare a TextEditingController provider',
    );
  }
}
