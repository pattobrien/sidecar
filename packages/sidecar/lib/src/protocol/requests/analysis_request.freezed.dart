// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'analysis_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnalysisRequest {
  String get path => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnalysisRequestCopyWith<AnalysisRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisRequestCopyWith<$Res> {
  factory $AnalysisRequestCopyWith(
          AnalysisRequest value, $Res Function(AnalysisRequest) then) =
      _$AnalysisRequestCopyWithImpl<$Res>;
  $Res call({String path});
}

/// @nodoc
class _$AnalysisRequestCopyWithImpl<$Res>
    implements $AnalysisRequestCopyWith<$Res> {
  _$AnalysisRequestCopyWithImpl(this._value, this._then);

  final AnalysisRequest _value;
  // ignore: unused_field
  final $Res Function(AnalysisRequest) _then;

  @override
  $Res call({
    Object? path = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_AnalysisRequestCopyWith<$Res>
    implements $AnalysisRequestCopyWith<$Res> {
  factory _$$_AnalysisRequestCopyWith(
          _$_AnalysisRequest value, $Res Function(_$_AnalysisRequest) then) =
      __$$_AnalysisRequestCopyWithImpl<$Res>;
  @override
  $Res call({String path});
}

/// @nodoc
class __$$_AnalysisRequestCopyWithImpl<$Res>
    extends _$AnalysisRequestCopyWithImpl<$Res>
    implements _$$_AnalysisRequestCopyWith<$Res> {
  __$$_AnalysisRequestCopyWithImpl(
      _$_AnalysisRequest _value, $Res Function(_$_AnalysisRequest) _then)
      : super(_value, (v) => _then(v as _$_AnalysisRequest));

  @override
  _$_AnalysisRequest get _value => super._value as _$_AnalysisRequest;

  @override
  $Res call({
    Object? path = freezed,
  }) {
    return _then(_$_AnalysisRequest(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AnalysisRequest extends _AnalysisRequest {
  const _$_AnalysisRequest({required this.path}) : super._();

  @override
  final String path;

  @override
  String toString() {
    return 'AnalysisRequest(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnalysisRequest &&
            const DeepCollectionEquality().equals(other.path, path));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(path));

  @JsonKey(ignore: true)
  @override
  _$$_AnalysisRequestCopyWith<_$_AnalysisRequest> get copyWith =>
      __$$_AnalysisRequestCopyWithImpl<_$_AnalysisRequest>(this, _$identity);
}

abstract class _AnalysisRequest extends AnalysisRequest {
  const factory _AnalysisRequest({required final String path}) =
      _$_AnalysisRequest;
  const _AnalysisRequest._() : super._();

  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$_AnalysisRequestCopyWith<_$_AnalysisRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
