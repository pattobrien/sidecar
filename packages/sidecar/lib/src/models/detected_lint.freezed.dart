// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'detected_lint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DetectedLint {
  LintRule get rule => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  LintRuleType get lintType => throw _privateConstructorUsedError;
  ResolvedUnitResult get unit => throw _privateConstructorUsedError;
  SourceSpan get sourceSpan => throw _privateConstructorUsedError;
  String? get correction => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetectedLintCopyWith<DetectedLint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectedLintCopyWith<$Res> {
  factory $DetectedLintCopyWith(
          DetectedLint value, $Res Function(DetectedLint) then) =
      _$DetectedLintCopyWithImpl<$Res>;
  $Res call(
      {LintRule rule,
      String message,
      LintRuleType lintType,
      ResolvedUnitResult unit,
      SourceSpan sourceSpan,
      String? correction});
}

/// @nodoc
class _$DetectedLintCopyWithImpl<$Res> implements $DetectedLintCopyWith<$Res> {
  _$DetectedLintCopyWithImpl(this._value, this._then);

  final DetectedLint _value;
  // ignore: unused_field
  final $Res Function(DetectedLint) _then;

  @override
  $Res call({
    Object? rule = freezed,
    Object? message = freezed,
    Object? lintType = freezed,
    Object? unit = freezed,
    Object? sourceSpan = freezed,
    Object? correction = freezed,
  }) {
    return _then(_value.copyWith(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as LintRule,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      lintType: lintType == freezed
          ? _value.lintType
          : lintType // ignore: cast_nullable_to_non_nullable
              as LintRuleType,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as ResolvedUnitResult,
      sourceSpan: sourceSpan == freezed
          ? _value.sourceSpan
          : sourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_DetectedLintCopyWith<$Res>
    implements $DetectedLintCopyWith<$Res> {
  factory _$$_DetectedLintCopyWith(
          _$_DetectedLint value, $Res Function(_$_DetectedLint) then) =
      __$$_DetectedLintCopyWithImpl<$Res>;
  @override
  $Res call(
      {LintRule rule,
      String message,
      LintRuleType lintType,
      ResolvedUnitResult unit,
      SourceSpan sourceSpan,
      String? correction});
}

/// @nodoc
class __$$_DetectedLintCopyWithImpl<$Res>
    extends _$DetectedLintCopyWithImpl<$Res>
    implements _$$_DetectedLintCopyWith<$Res> {
  __$$_DetectedLintCopyWithImpl(
      _$_DetectedLint _value, $Res Function(_$_DetectedLint) _then)
      : super(_value, (v) => _then(v as _$_DetectedLint));

  @override
  _$_DetectedLint get _value => super._value as _$_DetectedLint;

  @override
  $Res call({
    Object? rule = freezed,
    Object? message = freezed,
    Object? lintType = freezed,
    Object? unit = freezed,
    Object? sourceSpan = freezed,
    Object? correction = freezed,
  }) {
    return _then(_$_DetectedLint(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as LintRule,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      lintType: lintType == freezed
          ? _value.lintType
          : lintType // ignore: cast_nullable_to_non_nullable
              as LintRuleType,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as ResolvedUnitResult,
      sourceSpan: sourceSpan == freezed
          ? _value.sourceSpan
          : sourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
      correction: correction == freezed
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DetectedLint extends _DetectedLint {
  const _$_DetectedLint(
      {required this.rule,
      required this.message,
      required this.lintType,
      required this.unit,
      required this.sourceSpan,
      this.correction})
      : super._();

  @override
  final LintRule rule;
  @override
  final String message;
  @override
  final LintRuleType lintType;
  @override
  final ResolvedUnitResult unit;
  @override
  final SourceSpan sourceSpan;
  @override
  final String? correction;

  @override
  String toString() {
    return 'DetectedLint(rule: $rule, message: $message, lintType: $lintType, unit: $unit, sourceSpan: $sourceSpan, correction: $correction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetectedLint &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.lintType, lintType) &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality()
                .equals(other.sourceSpan, sourceSpan) &&
            const DeepCollectionEquality()
                .equals(other.correction, correction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(lintType),
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(sourceSpan),
      const DeepCollectionEquality().hash(correction));

  @JsonKey(ignore: true)
  @override
  _$$_DetectedLintCopyWith<_$_DetectedLint> get copyWith =>
      __$$_DetectedLintCopyWithImpl<_$_DetectedLint>(this, _$identity);
}

abstract class _DetectedLint extends DetectedLint {
  const factory _DetectedLint(
      {required final LintRule rule,
      required final String message,
      required final LintRuleType lintType,
      required final ResolvedUnitResult unit,
      required final SourceSpan sourceSpan,
      final String? correction}) = _$_DetectedLint;
  const _DetectedLint._() : super._();

  @override
  LintRule get rule;
  @override
  String get message;
  @override
  LintRuleType get lintType;
  @override
  ResolvedUnitResult get unit;
  @override
  SourceSpan get sourceSpan;
  @override
  String? get correction;
  @override
  @JsonKey(ignore: true)
  _$$_DetectedLintCopyWith<_$_DetectedLint> get copyWith =>
      throw _privateConstructorUsedError;
}
