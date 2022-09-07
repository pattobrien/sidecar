import 'package:sidecar/sidecar.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';

class CreateTextEditControllerProvider extends CodeEdit {
  CreateTextEditControllerProvider(super.ref);

  @override
  String get message => 'Declare a TextEditingController provider';

  @override
  Future<PrioritizedSourceChange> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    final session = requestedCodeEdit.sourceUnit.session;
    final unit = requestedCodeEdit.sourceUnit;
    final changeBuilder = ChangeBuilder(session: session);
    final node = requestedCodeEdit.sourceNode;
    if (node.parent?.parent is NamedExpression) {
      final expression = node.parent?.parent as NamedExpression;
      final argumentOffset = expression.expression.beginToken.offset - 1;
      final labelElement = expression.name.label.staticElement;
      // how to check for element type
      await changeBuilder.addDartFileEdit(
        requestedCodeEdit.sourceUnit.path,
        (builder) {
          builder.addInsertion(argumentOffset, (builder) {
            builder.write('ref.watch(myTextControllerProvider),');
          });
          builder.addInsertion(unit.unit.length, (builder) {
            builder.write('\n// ${expression.name.label.staticElement}');
            builder.write('\n// ${expression.name.label.name}');
            builder.writeChangeNotifierProvider(
              changeNotifier: 'TextEditingController()',
              variableName: 'myTextControllerProvider',
            );
          });
        },
      );
    } else {
      await changeBuilder.addDartFileEdit(
        requestedCodeEdit.sourceUnit.path,
        (builder) {
          builder.addInsertion(unit.unit.length, (builder) {
            builder.write(
                '\n// node: ${node.runtimeType} || parent: ${node.parent.runtimeType} || parent.parent: ${node.parent?.parent.runtimeType}');
          });
        },
      );
    }
    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange..message = message,
    );
  }
}
