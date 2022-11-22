import 'package:sidecar/src/protocol/protocol.dart';
import 'package:test/test.dart';

void expectLints(
  dynamic actual,
  List<ExpectedLint> expectedLints,
) {
  expect(actual, isA<LintNotification>(), reason: 'Not lint notification');

  actual as LintNotification;

  expect(actual.lints.length, expectedLints.length,
      reason: 'Number of lints != number of expected lints');

  for (var i = 0; i < expectedLints.length; i++) {
    final actualLint = actual.lints.toList()[i];
    final expectedLint = expectedLints[i];
    expectLintResult(actualLint, expectedLint);
  }
}

void expectLintResult(
  LintResult actual,
  ExpectedLint expectedLint,
) {
  // if (actual.rule != expectedLint.code) fail('code');
  // if (actual.span.start.offset != expectedLint.offset) fail('offset');
  // if (actual.span.length != expectedLint.length) fail('length');
  expect(actual.rule, expectedLint.code, reason: 'code does not match');
  expect(actual.span.start.offset, expectedLint.offset,
      reason: 'offset doesnt match');
  expect(actual.span.length, expectedLint.length, reason: 'invalid length');
}

// void expectLint(
//   dynamic actual,
//   ExpectedLint expectedLint,
// ) {
//   if (actual is! LintNotification) fail('Not a LintNotification');
//   if (actual.lints.length != 1) fail('length');
//   if (actual.lints.first.rule != expectedLint.code) fail('code');
//   if (actual.lints.first.span.start.offset != expectedLint.offset)
//     fail('offset');
//   if (actual.lints.first.span.length != expectedLint.length) fail('length');
// }

ExpectedLint lint(RuleCode code, int offset, int length) =>
    ExpectedLint(code, offset, length);

class ExpectedLint {
  ExpectedLint(
    this.code,
    this.offset,
    this.length,
  );
  final RuleCode code;
  final int offset;
  final int length;
}
