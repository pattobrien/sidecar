import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int calculate() {
  final aStringThatShouldBeLinted = 'some string that should be linted';

  return 6 * 7;
}

class SomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final someString = 'translation';
    final someString2 = someString;
    return Column(
      children: [
        TextFormField(
          controller: TextEditingController(),
        ),
        Text('some declaration'),
        Text(someString),
        Text(someString2),
      ],
    );
  }
}
// node: ArgumentListImpl || parent: InstanceCreationExpressionImpl || parent.parent: ReturnStatementImpl || parent.parent.parent: BlockImpl
// node: LabelImpl || parent: NamedExpressionImpl || parent.parent: ArgumentListImpl || parent.parent.parent: InstanceCreationExpressionImpl
// node => parents: VariableDeclarationListImpl => VariableDeclarationStatementImpl => BlockImpl => BlockFunctionBodyImpl
// node => parents: SimpleStringLiteralImpl => ArgumentListImpl => InstanceCreationExpressionImpl => ListLiteralImpl
// node => parents: SimpleStringLiteralImpl => VariableDeclarationImpl => VariableDeclarationListImpl => VariableDeclarationStatementImpl