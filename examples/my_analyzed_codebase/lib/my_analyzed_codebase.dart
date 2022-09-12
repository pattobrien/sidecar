//
import 'package:flutter/material.dart';

int calculate() {
  final aStringThatShouldBeLinted = 'some string that should be linted';
  final x = aStringThatShouldBeLinted;

  return 6 * 7;
}

class SomePage extends StatelessWidget {
  final color = Color(0x123);
  @override
  Widget build(BuildContext context) {
    final someString = 'translation';
    final someString2 = someString;
    final x = Color(123);
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

class MyNewPage extends StatelessWidget {
  const MyNewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}
// my map: {nested_value: [123]}
// node => parents: DeclaredSimpleIdentifier => ClassDeclarationImpl => CompilationUnitImpl => Null