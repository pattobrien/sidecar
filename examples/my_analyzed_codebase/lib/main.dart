import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(MyApp());
}

// @designSystem
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        textTheme: TextTheme(
          //
          bodyText1: TextStyle(),
        ),
      ),
    );
  }
}
