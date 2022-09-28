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
  SidecarBase get rule => throw _privateConstructorUsedError;
  AnalysisResult get result => throw _privateConstructorUsedError;
  LintRuleType get lintType => throw _privateConstructorUsedError;
  ResolvedUnitResult get unit => throw _privateConstructorUsedError;

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
      {SidecarBase rule,
      AnalysisResult result,
      LintRuleType lintType,
      ResolvedUnitResult unit});

  $AnalysisResultCopyWith<$Res> get result;
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
    Object? result = freezed,
    Object? lintType = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as SidecarBase,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as AnalysisResult,
      lintType: lintType == freezed
          ? _value.lintType
          : lintType // ignore: cast_nullable_to_non_nullable
              as LintRuleType,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as ResolvedUnitResult,
    ));
  }

  @override
  $AnalysisResultCopyWith<$Res> get result {
    return $AnalysisResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
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
      {SidecarBase rule,
      AnalysisResult result,
      LintRuleType lintType,
      ResolvedUnitResult unit});

  @override
  $AnalysisResultCopyWith<$Res> get result;
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
    Object? result = freezed,
    Object? lintType = freezed,
    Object? unit = freezed,
  }) {
    return _then(_$_DetectedLint(
      rule: rule == freezed
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
              as SidecarBase,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as AnalysisResult,
      lintType: lintType == freezed
          ? _value.lintType
          : lintType // ignore: cast_nullable_to_non_nullable
              as LintRuleType,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as ResolvedUnitResult,
    ));
  }
}

/// @nodoc

class _$_DetectedLint extends _DetectedLint {
  const _$_DetectedLint(
      {required this.rule,
      required this.result,
      required this.lintType,
      required this.unit})
      : super._();

  @override
  final SidecarBase rule;
  @override
  final AnalysisResult result;
  @override
  final LintRuleType lintType;
  @override
  final ResolvedUnitResult unit;

  @override
  String toString() {
    return 'DetectedLint(rule: $rule, result: $result, lintType: $lintType, unit: $unit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetectedLint &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality().equals(other.result, result) &&
            const DeepCollectionEquality().equals(other.lintType, lintType) &&
            const DeepCollectionEquality().equals(other.unit, unit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(rule),
      const DeepCollectionEquality().hash(result),
      const DeepCollectionEquality().hash(lintType),
      const DeepCollectionEquality().hash(unit));

  @JsonKey(ignore: true)
  @override
  _$$_DetectedLintCopyWith<_$_DetectedLint> get copyWith =>
      __$$_DetectedLintCopyWithImpl<_$_DetectedLint>(this, _$identity);
}

abstract class _DetectedLint extends DetectedLint {
  const factory _DetectedLint(
      {required final SidecarBase rule,
      required final AnalysisResult result,
      required final LintRuleType lintType,
      required final ResolvedUnitResult unit}) = _$_DetectedLint;
  const _DetectedLint._() : super._();

  @override
  SidecarBase get rule;
  @override
  AnalysisResult get result;
  @override
  LintRuleType get lintType;
  @override
  ResolvedUnitResult get unit;
  @override
  @JsonKey(ignore: true)
  _$$_DetectedLintCopyWith<_$_DetectedLint> get copyWith =>
      throw _privateConstructorUsedError;
}
