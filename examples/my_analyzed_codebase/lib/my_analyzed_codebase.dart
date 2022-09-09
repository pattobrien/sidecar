//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int calculate() {
  final aStringThatShouldBeLinted = 'some string that should be linted';
  final x = aStringThatShouldBeLinted;
  return 6 * 7;
}

class SomePage extends ConsumerWidget {
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

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}
