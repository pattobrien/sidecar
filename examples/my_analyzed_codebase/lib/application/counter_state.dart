import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'async.dart';

class TestWidget extends ConsumerWidget {
  const TestWidget({Key? key, this.val}) : super(key: key);

  final FutureA? val;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final x = File('');

    return Container();
  }
}
