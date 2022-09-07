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
    return TextFormField(
      controller: ref.watch(myTextControllerProvider),
    );
  }
}

final myTextControllerProvider = ChangeNotifierProvider((ref) {
  return TextEditingController();
});
