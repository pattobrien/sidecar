// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'root_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RootResponse {
  ContextRoot get root => throw _privateConstructorUsedError;
  Response get response => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RootResponseCopyWith<RootResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RootResponseCopyWith<$Res> {
  factory $RootResponseCopyWith(
          RootResponse value, $Res Function(RootResponse) then) =
      _$RootResponseCopyWithImpl<$Res>;
  $Res call({ContextRoot root, Response response});
}

/// @nodoc
class _$RootResponseCopyWithImpl<$Res> implements $RootResponseCopyWith<$Res> {
  _$RootResponseCopyWithImpl(this._value, this._then);

  final RootResponse _value;
  // ignore: unused_field
  final $Res Function(RootResponse) _then;

  @override
  $Res call({
    Object? root = freezed,
    Object? response = freezed,
  }) {
    return _then(_value.copyWith(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response,
    ));
  }
}

/// @nodoc
abstract class _$$_RootResponseCopyWith<$Res>
    implements $RootResponseCopyWith<$Res> {
  factory _$$_RootResponseCopyWith(
          _$_RootResponse value, $Res Function(_$_RootResponse) then) =
      __$$_RootResponseCopyWithImpl<$Res>;
  @override
  $Res call({ContextRoot root, Response response});
}

/// @nodoc
class __$$_RootResponseCopyWithImpl<$Res>
    extends _$RootResponseCopyWithImpl<$Res>
    implements _$$_RootResponseCopyWith<$Res> {
  __$$_RootResponseCopyWithImpl(
      _$_RootResponse _value, $Res Function(_$_RootResponse) _then)
      : super(_value, (v) => _then(v as _$_RootResponse));

  @override
  _$_RootResponse get _value => super._value as _$_RootResponse;

  @override
  $Res call({
    Object? root = freezed,
    Object? response = freezed,
  }) {
    return _then(_$_RootResponse(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response,
    ));
  }
}

/// @nodoc

class _$_RootResponse extends _RootResponse {
  const _$_RootResponse({required this.root, required this.response})
      : super._();

  @override
  final ContextRoot root;
  @override
  final Response response;

  @override
  String toString() {
    return 'RootResponse(root: $root, response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RootResponse &&
            const DeepCollectionEquality().equals(other.root, root) &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(root),
      const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  _$$_RootResponseCopyWith<_$_RootResponse> get copyWith =>
      __$$_RootResponseCopyWithImpl<_$_RootResponse>(this, _$identity);
}

abstract class _RootResponse extends RootResponse {
  const factory _RootResponse(
      {required final ContextRoot root,
      required final Response response}) = _$_RootResponse;
  const _RootResponse._() : super._();

  @override
  ContextRoot get root;
  @override
  Response get response;
  @override
  @JsonKey(ignore: true)
  _$$_RootResponseCopyWith<_$_RootResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
