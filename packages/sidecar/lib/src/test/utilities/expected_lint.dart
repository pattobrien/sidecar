import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

import '../../../rules/rules.dart';
import '../../protocol/communication/communication.dart';
import '../../protocol/models/models.dart';

part 'expected_lint.freezed.dart';

@freezed
class ExpectedLint with _$ExpectedLint {
  const factory ExpectedLint(
    RuleCode code,
    int offset,
    int length,
  ) = _ExpectedLint;

  const ExpectedLint._();
}

@freezed
class ExpectedText with _$ExpectedText {
  factory ExpectedText(
    String text, {
    int? offset,
    int? length,
    int? startLine,
    int? startColumn,
  }) = _ExpectedText;

  const ExpectedText._();
}

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
  // if (expectedLint.severity != null) {
  //   expect(actual.severity, expectedLint.severity,
  //       reason: 'severity doesnt match');
  // }
}

ExpectedLint lint(
  RuleCode code,
  int offset,
  int length, {
  LintSeverity? severity,
}) =>
    ExpectedLint(code, offset, length);
