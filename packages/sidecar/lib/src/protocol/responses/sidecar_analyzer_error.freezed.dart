// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sidecar_analyzer_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SidecarAnalyzerError {
  Object? get error => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SidecarAnalyzerErrorCopyWith<SidecarAnalyzerError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarAnalyzerErrorCopyWith<$Res> {
  factory $SidecarAnalyzerErrorCopyWith(SidecarAnalyzerError value,
          $Res Function(SidecarAnalyzerError) then) =
      _$SidecarAnalyzerErrorCopyWithImpl<$Res>;
  $Res call({Object? error, StackTrace? stackTrace});
}

/// @nodoc
class _$SidecarAnalyzerErrorCopyWithImpl<$Res>
    implements $SidecarAnalyzerErrorCopyWith<$Res> {
  _$SidecarAnalyzerErrorCopyWithImpl(this._value, this._then);

  final SidecarAnalyzerError _value;
  // ignore: unused_field
  final $Res Function(SidecarAnalyzerError) _then;

  @override
  $Res call({
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_value.copyWith(
      error: error == freezed ? _value.error : error,
      stackTrace: stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc
abstract class _$$_SidecarAnalyzerErrorCopyWith<$Res>
    implements $SidecarAnalyzerErrorCopyWith<$Res> {
  factory _$$_SidecarAnalyzerErrorCopyWith(_$_SidecarAnalyzerError value,
          $Res Function(_$_SidecarAnalyzerError) then) =
      __$$_SidecarAnalyzerErrorCopyWithImpl<$Res>;
  @override
  $Res call({Object? error, StackTrace? stackTrace});
}

/// @nodoc
class __$$_SidecarAnalyzerErrorCopyWithImpl<$Res>
    extends _$SidecarAnalyzerErrorCopyWithImpl<$Res>
    implements _$$_SidecarAnalyzerErrorCopyWith<$Res> {
  __$$_SidecarAnalyzerErrorCopyWithImpl(_$_SidecarAnalyzerError _value,
      $Res Function(_$_SidecarAnalyzerError) _then)
      : super(_value, (v) => _then(v as _$_SidecarAnalyzerError));

  @override
  _$_SidecarAnalyzerError get _value => super._value as _$_SidecarAnalyzerError;

  @override
  $Res call({
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$_SidecarAnalyzerError(
      error == freezed ? _value.error : error,
      stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$_SidecarAnalyzerError extends _SidecarAnalyzerError {
  const _$_SidecarAnalyzerError(this.error, this.stackTrace) : super._();

  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'SidecarAnalyzerError(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SidecarAnalyzerError &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  _$$_SidecarAnalyzerErrorCopyWith<_$_SidecarAnalyzerError> get copyWith =>
      __$$_SidecarAnalyzerErrorCopyWithImpl<_$_SidecarAnalyzerError>(
          this, _$identity);
}

abstract class _SidecarAnalyzerError extends SidecarAnalyzerError {
  const factory _SidecarAnalyzerError(
          final Object? error, final StackTrace? stackTrace) =
      _$_SidecarAnalyzerError;
  const _SidecarAnalyzerError._() : super._();

  @override
  Object? get error;
  @override
  StackTrace? get stackTrace;
  @override
  @JsonKey(ignore: true)
  _$$_SidecarAnalyzerErrorCopyWith<_$_SidecarAnalyzerError> get copyWith =>
      throw _privateConstructorUsedError;
}
