import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/icons.dart';

calculate() {
  final aStringThatShouldBeLinted = 'some string that should be linted';
  final x = aStringThatShouldBeLinted;
  return 6 * 7;
}

class SomePage extends ConsumerWidget {
  final color = Color(0x12345678);
  final insets = EdgeInsets.all(10);
  //
  final shadow = BoxShadow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final someString = 'translation';
    final someString2 = someString;
    final someIconData = Icons.abc;

    final someIconData2 = Icons.snowboarding;

    final double someNumber = 10.0;
    final x = Color(123);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Icon(
            Icons.abc,
            color: x,
          ),
          Icon(
            someIconData,
            color: x,
          ),
          SizedBox(width: 10.0),
          Icon(
            someIconData,
            color: x,
          ),
          SizedBox(width: 10.0),

          SizedBox(width: someNumber),
          Icon(Icons.snowboarding),
          // Icon(ProjectIcons.abc),
          TextFormField(
            controller: ref.watch(myTextControllerProvider),
          ),
          Text(AppLocalizations.of(context).string123),
          Text(someString),
          Text(someString2),
        ],
      ),
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
