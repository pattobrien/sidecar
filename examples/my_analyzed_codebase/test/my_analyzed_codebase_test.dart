import 'package:my_analyzed_codebase/my_analyzed_codebase.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });
}

final someString = 'this string shouldnt be analyzed';
