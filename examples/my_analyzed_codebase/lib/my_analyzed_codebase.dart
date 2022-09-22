import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/icons.dart';

int calculate() {
  final aStringThatShouldBeLinted = 'some string that should be linted';
  final x = aStringThatShouldBeLinted;
  return 6 * 7;
}

class SomePage extends ConsumerWidget {
  final color = Color(0x12345678);
  final insets = EdgeInsets.all(10);
  final shadow = BoxShadow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final someString = 'translation';
    final someString2 = someString;
    final someIconData = Icons.abc;
    final double someNumnber = 10;
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
          SizedBox(width: someNumnber),
          Icon(Icons.abc),
          Icon(ProjectIcons.abc),
          TextFormField(
            controller: ref.watch(myTextControllerProvider),
          ),
          Text('some declaration'),
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


// someIconData (node => parents): SimpleIdentifierImpl => ArgumentListImpl => InstanceCreationExpressionImpl => ListLiteralImpl

// abc (node => parents): SimpleIdentifierImpl => PrefixedIdentifierImpl => ArgumentListImpl => InstanceCreationExpressionImpl

// Icons (node => parents): SimpleIdentifierImpl => PrefixedIdentifierImpl => ArgumentListImpl => InstanceCreationExpressionImpl

// width (node => parents): SimpleIdentifierImpl => LabelImpl => NamedExpressionImpl => ArgumentListImpl

// 10 (node => parents): IntegerLiteralImpl => NamedExpressionImpl => ArgumentListImpl => InstanceCreationExpressionImpl

// 10.0 (node => parents): DoubleLiteralImpl => NamedExpressionImpl => ArgumentListImpl => InstanceCreationExpressionImpl

// someNumnber (node => parents): SimpleIdentifierImpl => NamedExpressionImpl => ArgumentListImpl => InstanceCreationExpressionImpl
