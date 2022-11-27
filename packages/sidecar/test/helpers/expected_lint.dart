import 'package:sidecar/sidecar.dart';
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
  expect(actual.rule, expectedLint.code, reason: 'code does not match');
  expect(actual.span.start.offset, expectedLint.offset,
      reason: 'offset doesnt match');
  expect(actual.span.length, expectedLint.length, reason: 'invalid length');
  if (expectedLint.severity != null) {
    expect(actual.severity, expectedLint.severity,
        reason: 'severity doesnt match');
  }
}

ExpectedLint lint(
  RuleCode code,
  int offset,
  int length, {
  LintSeverity? severity,
}) =>
    ExpectedLint(code, offset, length, severity: severity);

class ExpectedLint {
  ExpectedLint(
    this.code,
    this.offset,
    this.length, {
    this.severity,
  });
  final RuleCode code;
  final int offset;
  final int length;
  final LintSeverity? severity;
}
