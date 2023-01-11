import 'dart:collection';

import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GlobalInsets.extraLarge,
        vertical: 20,
      ),
      margin: EdgeInsets.symmetric(
        // vertical: Values().someValue,
        vertical: A().thisValue,
        horizontal: GlobalInsets.finalValue,
      ),
    );
  }
}

class GlobalInsets {
  static const double xsmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double extraLarge = Values.someValue;

  static final double finalValue = 20;
}

class Values {
  static const double someValue = 20.0;
}

class A {
  A();
  final thisValue = 0.0;
}
