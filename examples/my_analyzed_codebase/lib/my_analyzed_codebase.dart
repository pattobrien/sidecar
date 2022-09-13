import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int calculate() {
  final aStringThatShouldBeLinted = 'some string that should be linted';
  final x = aStringThatShouldBeLinted;

  return 6 * 7;
}

class SomePage extends ConsumerWidget {
  final color = Color(0x1234567);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final someString = 'translation';
    final someString2 = someString;
    final x = Color(123);
    return Column(
      children: [
        TextFormField(
          controller: ref.watch(myTextControllerProvider),
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

final myTextControllerProvider = ChangeNotifierProvider((ref) {
  return TextEditingController();
});
