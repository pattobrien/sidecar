import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../protocol.dart';

@immutable
class AnalysisResults extends UnmodifiableSetView<AnalysisResult> {
  AnalysisResults(this._source) : super(_source);

  final Set<AnalysisResult> _source;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AnalysisResults &&
            const SetEquality<AnalysisResult>().equals(other._source, _source));
  }

  @override
  int get hashCode => const SetEquality<AnalysisResult>().hash(_source);
}

@immutable
class AssistResults extends UnmodifiableSetView<AssistResult> {
  AssistResults(this._source) : super(_source);

  final Set<AssistResult> _source;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AssistResults &&
            const SetEquality<AssistResult>().equals(other._source, _source));
  }

  @override
  int get hashCode => const SetEquality<AssistResult>().hash(_source);
}

@immutable
class LintResults extends EqualUnmodifiableSetView<LintResult> {
  LintResults(this._source) : super(_source);

  final Set<LintResult> _source;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LintResults &&
            const SetEquality<LintResult>().equals(other._source, _source));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const SetEquality<LintResult>().hash(_source));
}

@immutable
class SingleDataResults extends UnmodifiableSetView<SingleDataResult> {
  SingleDataResults(this._source) : super(_source);

  final Set<SingleDataResult> _source;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SingleDataResults &&
            const SetEquality<SingleDataResult>()
                .equals(other._source, _source));
  }

  @override
  int get hashCode => const SetEquality<SingleDataResult>().hash(_source);
}

@immutable
class TotalDataResults extends UnmodifiableSetView<TotalDataResult> {
  TotalDataResults(this._source) : super(_source);

  final Set<TotalDataResult> _source;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TotalDataResults &&
            const SetEquality<TotalDataResult>()
                .equals(other._source, _source));
  }

  @override
  int get hashCode => const SetEquality<TotalDataResult>().hash(_source);
}
