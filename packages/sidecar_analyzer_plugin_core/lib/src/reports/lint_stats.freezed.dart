// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lint_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LintStats {
  Duration get timeToLint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LintStatsCopyWith<LintStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LintStatsCopyWith<$Res> {
  factory $LintStatsCopyWith(LintStats value, $Res Function(LintStats) then) =
      _$LintStatsCopyWithImpl<$Res>;
  $Res call({Duration timeToLint});
}

/// @nodoc
class _$LintStatsCopyWithImpl<$Res> implements $LintStatsCopyWith<$Res> {
  _$LintStatsCopyWithImpl(this._value, this._then);

  final LintStats _value;
  // ignore: unused_field
  final $Res Function(LintStats) _then;

  @override
  $Res call({
    Object? timeToLint = freezed,
  }) {
    return _then(_value.copyWith(
      timeToLint: timeToLint == freezed
          ? _value.timeToLint
          : timeToLint // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
abstract class _$$_LintStatsCopyWith<$Res> implements $LintStatsCopyWith<$Res> {
  factory _$$_LintStatsCopyWith(
          _$_LintStats value, $Res Function(_$_LintStats) then) =
      __$$_LintStatsCopyWithImpl<$Res>;
  @override
  $Res call({Duration timeToLint});
}

/// @nodoc
class __$$_LintStatsCopyWithImpl<$Res> extends _$LintStatsCopyWithImpl<$Res>
    implements _$$_LintStatsCopyWith<$Res> {
  __$$_LintStatsCopyWithImpl(
      _$_LintStats _value, $Res Function(_$_LintStats) _then)
      : super(_value, (v) => _then(v as _$_LintStats));

  @override
  _$_LintStats get _value => super._value as _$_LintStats;

  @override
  $Res call({
    Object? timeToLint = freezed,
  }) {
    return _then(_$_LintStats(
      timeToLint: timeToLint == freezed
          ? _value.timeToLint
          : timeToLint // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_LintStats extends _LintStats {
  const _$_LintStats({required this.timeToLint}) : super._();

  @override
  final Duration timeToLint;

  @override
  String toString() {
    return 'LintStats(timeToLint: $timeToLint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LintStats &&
            const DeepCollectionEquality()
                .equals(other.timeToLint, timeToLint));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(timeToLint));

  @JsonKey(ignore: true)
  @override
  _$$_LintStatsCopyWith<_$_LintStats> get copyWith =>
      __$$_LintStatsCopyWithImpl<_$_LintStats>(this, _$identity);
}

abstract class _LintStats extends LintStats {
  const factory _LintStats({required final Duration timeToLint}) = _$_LintStats;
  const _LintStats._() : super._();

  @override
  Duration get timeToLint;
  @override
  @JsonKey(ignore: true)
  _$$_LintStatsCopyWith<_$_LintStats> get copyWith =>
      throw _privateConstructorUsedError;
}
