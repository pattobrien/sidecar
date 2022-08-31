import 'package:sidecar/sidecar.dart';

class DeclareTecProvider extends CodeEdit {
  DeclareTecProvider(super.ref);

  @override
  String get id => 'declare_tec_provider';

  @override
  String get message => 'Declare a TextEditingController provider';

  @override
  Future<PrioritizedSourceChange> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    final session = requestedCodeEdit.sourceUnit.session;
    final unit = requestedCodeEdit.sourceUnit;
    final changeBuilder = ChangeBuilder(session: session);

    await changeBuilder.addDartFileEdit(
      requestedCodeEdit.sourceUnit.path,
      (builder) {
        builder.addInsertion(unit.unit.length, (builder) {
          builder.writeChangeNotifierProvider(
            changeNotifier: 'TextEditingController()',
            variableName: 'myTextControllerProvider',
          );
        });
      },
    );
    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange..message = message,
    );
  }
}
