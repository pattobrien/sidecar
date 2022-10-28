// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analysis_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalysisResult {
  AnalysisSourceSpan get span => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<EditResult> get edits => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LintRule rule,
            AnalysisSourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lint,
    required TResult Function(AssistRule rule, AnalysisSourceSpan span,
            String message, List<EditResult> edits)
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(LintRule rule, AnalysisSourceSpan span, String message,
            LintSeverity severity, String? correction, List<EditResult> edits)?
        lint,
    TResult Function(AssistRule rule, AnalysisSourceSpan span, String message,
            List<EditResult> edits)?
        assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LintRule rule, AnalysisSourceSpan span, String message,
            LintSeverity severity, String? correction, List<EditResult> edits)?
        lint,
    TResult Function(AssistRule rule, AnalysisSourceSpan span, String message,
            List<EditResult> edits)?
        assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(AssistResult value) assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(AssistResult value)? assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(AssistResult value)? assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalysisResultCopyWith<AnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisResultCopyWith<$Res> {
  factory $AnalysisResultCopyWith(
          AnalysisResult value, $Res Function(AnalysisResult) then) =
      _$AnalysisResultCopyWithImpl<$Res>;
  $Res call({AnalysisSourceSpan span, String message, List<EditResult> edits});
}

/// @nodoc
class _$AnalysisResultCopyWithImpl<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  _$AnalysisResultCopyWithImpl(this._value, this._then);

  final AnalysisResult _value;
  // ignore: unused_field
  final $Res Function(AnalysisResult) _then;

  @override
  $Res call({
    Object? span = freezed,
    Object? message = freezed,
    Object? edits = freezed,
  }) {
    return _then(_value.copyWith(
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as AnalysisSourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      edits: edits == freezed
          ? _value.edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }
}

/// @nodoc
abstract class _$$LintResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$LintResultCopyWith(
          _$LintResult value, $Res Function(_$LintResult) then) =
      __$$LintResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {LintRule rule,
      AnalysisSourceSpan span,
      String message,
      LintSeverity severity,
      String? correction,
      List<EditResult> edits});
}

/// @nodoc
class __$$LintResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res>
    implements _$$LintResultCopyWith<$Res> {
  __$$LintResultCopyWithImpl(
      _$LintResult _value, $Res Function(_$LintResult) _then)
      : super(_value, (v) => _then(v as _$LintResult));

  @override
  _$LintResult get _value => super._value as _$LintResult;

  @override
  $Res call({
    Object? rule = freezed,
    Object? span = freezed,
    Object? message = freezed,
    Object? severity = freezed,
    Object? correction = freezed,
    Object? edits = freezed,
  }) {
    return _then(_$LintResult(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as LintRule,
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as AnalysisSourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: severity == freezed
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as LintSeverity,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      edits: edits == freezed
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }
}

/// @nodoc

class _$LintResult extends LintResult {
  const _$LintResult(
      {required this.rule,
      required this.span,
      required this.message,
      required this.severity,
      this.correction,
      final List<EditResult> edits = const <EditResult>[]})
      : _edits = edits,
        super._();

  @override
  final LintRule rule;
  @override
  final AnalysisSourceSpan span;
  @override
  final String message;
  @override
  final LintSeverity severity;
  @override
  final String? correction;
  final List<EditResult> _edits;
  @override
  @JsonKey()
  List<EditResult> get edits {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edits);
  }

  @override
  String toString() {
    return 'AnalysisResult.lint(rule: $rule, span: $span, message: $message, severity: $severity, correction: $correction, edits: $edits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintResult &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality().equals(other.span, span) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.severity, severity) &&
            const DeepCollectionEquality()
                .equals(other.correction, correction) &&
            const DeepCollectionEquality().equals(other._edits, _edits));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(span),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(severity),
      const DeepCollectionEquality().hash(correction),
      const DeepCollectionEquality().hash(_edits));

  @JsonKey(ignore: true)
  @override
  _$$LintResultCopyWith<_$LintResult> get copyWith =>
      __$$LintResultCopyWithImpl<_$LintResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LintRule rule,
            AnalysisSourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lint,
    required TResult Function(AssistRule rule, AnalysisSourceSpan span,
            String message, List<EditResult> edits)
        assist,
  }) {
    return lint(rule, span, message, severity, correction, edits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(LintRule rule, AnalysisSourceSpan span, String message,
            LintSeverity severity, String? correction, List<EditResult> edits)?
        lint,
    TResult Function(AssistRule rule, AnalysisSourceSpan span, String message,
            List<EditResult> edits)?
        assist,
  }) {
    return lint?.call(rule, span, message, severity, correction, edits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LintRule rule, AnalysisSourceSpan span, String message,
            LintSeverity severity, String? correction, List<EditResult> edits)?
        lint,
    TResult Function(AssistRule rule, AnalysisSourceSpan span, String message,
            List<EditResult> edits)?
        assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(rule, span, message, severity, correction, edits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(AssistResult value) assist,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(AssistResult value)? assist,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(AssistResult value)? assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }
}

abstract class LintResult extends AnalysisResult {
  const factory LintResult(
      {required final LintRule rule,
      required final AnalysisSourceSpan span,
      required final String message,
      required final LintSeverity severity,
      final String? correction,
      final List<EditResult> edits}) = _$LintResult;
  const LintResult._() : super._();

  LintRule get rule;
  @override
  AnalysisSourceSpan get span;
  @override
  String get message;
  LintSeverity get severity;
  String? get correction;
  @override
  List<EditResult> get edits;
  @override
  @JsonKey(ignore: true)
  _$$LintResultCopyWith<_$LintResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistResultCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$AssistResultCopyWith(
          _$AssistResult value, $Res Function(_$AssistResult) then) =
      __$$AssistResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {AssistRule rule,
      AnalysisSourceSpan span,
      String message,
      List<EditResult> edits});
}

/// @nodoc
class __$$AssistResultCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res>
    implements _$$AssistResultCopyWith<$Res> {
  __$$AssistResultCopyWithImpl(
      _$AssistResult _value, $Res Function(_$AssistResult) _then)
      : super(_value, (v) => _then(v as _$AssistResult));

  @override
  _$AssistResult get _value => super._value as _$AssistResult;

  @override
  $Res call({
    Object? rule = freezed,
    Object? span = freezed,
    Object? message = freezed,
    Object? edits = freezed,
  }) {
    return _then(_$AssistResult(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as AssistRule,
      span: span == freezed
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as AnalysisSourceSpan,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      edits: edits == freezed
          ? _value._edits
          : edits // ignore: cast_nullable_to_non_nullable
              as List<EditResult>,
    ));
  }
}

/// @nodoc

class _$AssistResult extends AssistResult {
  const _$AssistResult(
      {required this.rule,
      required this.span,
      required this.message,
      final List<EditResult> edits = const <EditResult>[]})
      : _edits = edits,
        super._();

  @override
  final AssistRule rule;
  @override
  final AnalysisSourceSpan span;
  @override
  final String message;
  final List<EditResult> _edits;
  @override
  @JsonKey()
  List<EditResult> get edits {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edits);
  }

  @override
  String toString() {
    return 'AnalysisResult.assist(rule: $rule, span: $span, message: $message, edits: $edits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistResult &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality().equals(other.span, span) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other._edits, _edits));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(span),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(_edits));

  @JsonKey(ignore: true)
  @override
  _$$AssistResultCopyWith<_$AssistResult> get copyWith =>
      __$$AssistResultCopyWithImpl<_$AssistResult>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LintRule rule,
            AnalysisSourceSpan span,
            String message,
            LintSeverity severity,
            String? correction,
            List<EditResult> edits)
        lint,
    required TResult Function(AssistRule rule, AnalysisSourceSpan span,
            String message, List<EditResult> edits)
        assist,
  }) {
    return assist(rule, span, message, edits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(LintRule rule, AnalysisSourceSpan span, String message,
            LintSeverity severity, String? correction, List<EditResult> edits)?
        lint,
    TResult Function(AssistRule rule, AnalysisSourceSpan span, String message,
            List<EditResult> edits)?
        assist,
  }) {
    return assist?.call(rule, span, message, edits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LintRule rule, AnalysisSourceSpan span, String message,
            LintSeverity severity, String? correction, List<EditResult> edits)?
        lint,
    TResult Function(AssistRule rule, AnalysisSourceSpan span, String message,
            List<EditResult> edits)?
        assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(rule, span, message, edits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintResult value) lint,
    required TResult Function(AssistResult value) assist,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(AssistResult value)? assist,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintResult value)? lint,
    TResult Function(AssistResult value)? assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }
}

abstract class AssistResult extends AnalysisResult {
  const factory AssistResult(
      {required final AssistRule rule,
      required final AnalysisSourceSpan span,
      required final String message,
      final List<EditResult> edits}) = _$AssistResult;
  const AssistResult._() : super._();

  AssistRule get rule;
  @override
  AnalysisSourceSpan get span;
  @override
  String get message;
  @override
  List<EditResult> get edits;
  @override
  @JsonKey(ignore: true)
  _$$AssistResultCopyWith<_$AssistResult> get copyWith =>
      throw _privateConstructorUsedError;
}
