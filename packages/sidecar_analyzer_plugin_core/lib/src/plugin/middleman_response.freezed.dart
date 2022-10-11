// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'middleman_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MiddlemanResponse {
  Request get request => throw _privateConstructorUsedError;
  List<ContextRoot> get roots => throw _privateConstructorUsedError;
  List<RootResponse> get responses => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MiddlemanResponseCopyWith<MiddlemanResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiddlemanResponseCopyWith<$Res> {
  factory $MiddlemanResponseCopyWith(
          MiddlemanResponse value, $Res Function(MiddlemanResponse) then) =
      _$MiddlemanResponseCopyWithImpl<$Res>;
  $Res call(
      {Request request,
      List<ContextRoot> roots,
      List<RootResponse> responses,
      DateTime timestamp});
}

/// @nodoc
class _$MiddlemanResponseCopyWithImpl<$Res>
    implements $MiddlemanResponseCopyWith<$Res> {
  _$MiddlemanResponseCopyWithImpl(this._value, this._then);

  final MiddlemanResponse _value;
  // ignore: unused_field
  final $Res Function(MiddlemanResponse) _then;

  @override
  $Res call({
    Object? request = freezed,
    Object? roots = freezed,
    Object? responses = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as Request,
      roots: roots == freezed
          ? _value.roots
          : roots // ignore: cast_nullable_to_non_nullable
              as List<ContextRoot>,
      responses: responses == freezed
          ? _value.responses
          : responses // ignore: cast_nullable_to_non_nullable
              as List<RootResponse>,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$$_MiddlemanResponseCopyWith<$Res>
    implements $MiddlemanResponseCopyWith<$Res> {
  factory _$$_MiddlemanResponseCopyWith(_$_MiddlemanResponse value,
          $Res Function(_$_MiddlemanResponse) then) =
      __$$_MiddlemanResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {Request request,
      List<ContextRoot> roots,
      List<RootResponse> responses,
      DateTime timestamp});
}

/// @nodoc
class __$$_MiddlemanResponseCopyWithImpl<$Res>
    extends _$MiddlemanResponseCopyWithImpl<$Res>
    implements _$$_MiddlemanResponseCopyWith<$Res> {
  __$$_MiddlemanResponseCopyWithImpl(
      _$_MiddlemanResponse _value, $Res Function(_$_MiddlemanResponse) _then)
      : super(_value, (v) => _then(v as _$_MiddlemanResponse));

  @override
  _$_MiddlemanResponse get _value => super._value as _$_MiddlemanResponse;

  @override
  $Res call({
    Object? request = freezed,
    Object? roots = freezed,
    Object? responses = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$_MiddlemanResponse(
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as Request,
      roots: roots == freezed
          ? _value._roots
          : roots // ignore: cast_nullable_to_non_nullable
              as List<ContextRoot>,
      responses: responses == freezed
          ? _value._responses
          : responses // ignore: cast_nullable_to_non_nullable
              as List<RootResponse>,
      timestamp: timestamp == freezed
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_MiddlemanResponse extends _MiddlemanResponse {
  const _$_MiddlemanResponse(
      {required this.request,
      required final List<ContextRoot> roots,
      required final List<RootResponse> responses,
      required this.timestamp})
      : _roots = roots,
        _responses = responses,
        super._();

  @override
  final Request request;
  final List<ContextRoot> _roots;
  @override
  List<ContextRoot> get roots {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roots);
  }

  final List<RootResponse> _responses;
  @override
  List<RootResponse> get responses {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_responses);
  }

  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MiddlemanResponse(request: $request, roots: $roots, responses: $responses, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MiddlemanResponse &&
            const DeepCollectionEquality().equals(other.request, request) &&
            const DeepCollectionEquality().equals(other._roots, _roots) &&
            const DeepCollectionEquality()
                .equals(other._responses, _responses) &&
            const DeepCollectionEquality().equals(other.timestamp, timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(request),
      const DeepCollectionEquality().hash(_roots),
      const DeepCollectionEquality().hash(_responses),
      const DeepCollectionEquality().hash(timestamp));

  @JsonKey(ignore: true)
  @override
  _$$_MiddlemanResponseCopyWith<_$_MiddlemanResponse> get copyWith =>
      __$$_MiddlemanResponseCopyWithImpl<_$_MiddlemanResponse>(
          this, _$identity);
}

abstract class _MiddlemanResponse extends MiddlemanResponse {
  const factory _MiddlemanResponse(
      {required final Request request,
      required final List<ContextRoot> roots,
      required final List<RootResponse> responses,
      required final DateTime timestamp}) = _$_MiddlemanResponse;
  const _MiddlemanResponse._() : super._();

  @override
  Request get request;
  @override
  List<ContextRoot> get roots;
  @override
  List<RootResponse> get responses;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_MiddlemanResponseCopyWith<_$_MiddlemanResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
