// Providers of different analyzer states

import 'dart:async';

import 'package:riverpod/riverpod.dart';

final eventQueueProvider = StateProvider<List<int>>((ref) {
  return [];
});

final eventQueueStreamProvider = StreamProvider<List<int>>((ref) {
  final controller = StreamController<List<int>>()..add([]);
  ref.onDispose(controller.close);
  ref.listen<List<int>>(eventQueueProvider, (_, next) => controller.add(next));
  return controller.stream;
});

enum AnalyzerStatus { analyzing, completed }
