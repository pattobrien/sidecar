import 'package:sidecar/sidecar.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';

class CreateTextEditControllerProvider extends CodeEdit {
  CreateTextEditControllerProvider(super.ref);

  @override
  String get code => 'create_text_edit_controller_provider';

  @override
  String get message => 'Declare a TextEditingController provider';

  @override
  Future<PrioritizedSourceChange> computeSourceChange(
    RequestedCodeEdit requestedCodeEdit,
  ) async {
    final session = requestedCodeEdit.sourceUnit.session;
    final unit = requestedCodeEdit.sourceUnit;
    final changeBuilder = ChangeBuilder(session: session);
    final myConfig = session
        .analysisContext
        .sidecarOptions
        .editPackages?['riverpod_lints']
        ?.edits['create_text_edit_controller_provider'];

    final node = requestedCodeEdit.sourceNode;
    if (node.parent?.parent is NamedExpression) {
      final expression = node.parent?.parent as NamedExpression;
      final argumentOffset = expression.expression.beginToken.offset - 1;
      final labelElement = expression.name.label.staticElement;
      // how to check for element type
      await changeBuilder.addDartFileEdit(
        requestedCodeEdit.sourceUnit.path,
        (builder) {
          final linkGroup = 'myTextControllerProvider';

          builder.addInsertion(unit.unit.length, (builder) {
            builder.write('\n// ${expression.name.label.staticElement}');
            builder.write('\n// ${expression.name.label.name}');
            // builder.writeChangeNotifierProvider(
            //   changeNotifier: 'TextEditingController()',
            //   variableName: 'myTextControllerProvider',
            // );
            return;
          });
          builder.addInsertion(argumentOffset, (builder) {
            builder.write('ref.watch(');

            builder.addLinkedEdit(linkGroup, (builder) {
              builder.write(linkGroup);
              // builder.addSuggestion(
              //     LinkedEditSuggestionKind.PARAMETER, linkGroup);
            });
            builder.write('), ');
            return;
          });
        },
      );
    } else {
      await changeBuilder.addDartFileEdit(
        requestedCodeEdit.sourceUnit.path,
        (builder) {
          builder.addInsertion(unit.unit.length, (builder) {
            builder.write(
                '\n// node => parents: ${node.runtimeType} => ${node.parent.runtimeType} => ${node.parent?.parent.runtimeType} => ${node.parent?.parent?.parent.runtimeType}');
          });
          builder.addInsertion(unit.unit.length, (builder) {
            builder.write('// my map: ${myConfig?.configuration}');
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
