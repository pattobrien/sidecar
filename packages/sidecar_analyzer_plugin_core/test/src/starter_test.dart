import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:test/scaffolding.dart';

import '../utils/analysis_collection.dart';

void main() {
  test('description', () {
    final container = ProviderContainer();
    print(Directory.current);
    final collection = createTestableCollectionForPath('root');
    addTearDown(container.dispose);
  });
}
