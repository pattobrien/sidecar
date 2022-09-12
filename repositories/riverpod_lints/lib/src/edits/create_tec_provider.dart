import 'package:sidecar/sidecar.dart';

class CreateTextEditControllerProvider extends CodeEdit {
  CreateTextEditControllerProvider(super.ref);

  @override
  String get code => 'create_text_edit_controller_provider';

  @override
  String get packageName => 'riverpod_lints';

  @override
  String get message => 'Declare a TextEditingController provider';

  @override
  Future<PrioritizedSourceChange?> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    final session = requestedCodeEdit.unit.session;
    final unit = requestedCodeEdit.unit;
    final changeBuilder = ChangeBuilder(session: session);

    final node = requestedCodeEdit.node;
    final parentNode = node.parent?.parent;
    if (parentNode is NamedExpression) {
      final argumentOffset = parentNode.expression.beginToken.offset - 1;

      await changeBuilder.addDartFileEdit(
        requestedCodeEdit.unit.path,
        (builder) {
          builder.addInsertion(unit.unit.length, (builder) {
            builder.write('\n// ${parentNode.name.label.staticElement}');
            builder.write('\n// ${parentNode.name.label.name}');
          });
          builder.addInsertion(argumentOffset, (builder) {
            builder.write('ref.watch(');
            builder.write('myTextControllerProvider');
            builder.write('), ');
          });
        },
      );
    } else {
      await changeBuilder.addDartFileEdit(
        requestedCodeEdit.unit.path,
        (builder) {
          builder.addInsertion(
            unit.unit.length,
            (builder) {
              builder.write(
                  '\n// node => parents: ${node.runtimeType} => ${node.parent.runtimeType} => ${node.parent?.parent.runtimeType} => ${node.parent?.parent?.parent.runtimeType}');
            },
          );
        },
      );
    }
    return PrioritizedSourceChange(
      0,
      changeBuilder.sourceChange..message = message,
    );
  }
}
