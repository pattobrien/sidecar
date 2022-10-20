// import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/pubspec.yaml';

void main() {
  runApp(MyApp());
}

// @designSystem
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icon = Icon(Icons.abc);
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.amber,
          textTheme: TextTheme(
            bodyText1: TextStyle(),
          )),
    );
  }
}
