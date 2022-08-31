import 'package:flutter/material.dart';
import 'package:my_analyzed_codebase/my_analyzed_codebase.dart';

void main(List<String> arguments) {
  print('Hello world: ${calculate()}!');
}

final someString = 'this is a string that should produce a lint error';

class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  //
}
