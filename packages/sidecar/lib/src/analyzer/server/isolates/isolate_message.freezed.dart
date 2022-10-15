// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'isolate_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IsolateMessage {
  ActiveContextRoot get root => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Request request, ActiveContextRoot root) request,
    required TResult Function(Response response, ActiveContextRoot root)
        response,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Request request, ActiveContextRoot root)? request,
    TResult Function(Response response, ActiveContextRoot root)? response,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Request request, ActiveContextRoot root)? request,
    TResult Function(Response response, ActiveContextRoot root)? response,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IsolateRequest value) request,
    required TResult Function(IsolateResponse value) response,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(IsolateRequest value)? request,
    TResult Function(IsolateResponse value)? response,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IsolateRequest value)? request,
    TResult Function(IsolateResponse value)? response,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IsolateMessageCopyWith<IsolateMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IsolateMessageCopyWith<$Res> {
  factory $IsolateMessageCopyWith(
          IsolateMessage value, $Res Function(IsolateMessage) then) =
      _$IsolateMessageCopyWithImpl<$Res>;
  $Res call({ActiveContextRoot root});
}

/// @nodoc
class _$IsolateMessageCopyWithImpl<$Res>
    implements $IsolateMessageCopyWith<$Res> {
  _$IsolateMessageCopyWithImpl(this._value, this._then);

  final IsolateMessage _value;
  // ignore: unused_field
  final $Res Function(IsolateMessage) _then;

  @override
  $Res call({
    Object? root = freezed,
  }) {
    return _then(_value.copyWith(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ActiveContextRoot,
    ));
  }
}

/// @nodoc
abstract class _$$IsolateRequestCopyWith<$Res>
    implements $IsolateMessageCopyWith<$Res> {
  factory _$$IsolateRequestCopyWith(
          _$IsolateRequest value, $Res Function(_$IsolateRequest) then) =
      __$$IsolateRequestCopyWithImpl<$Res>;
  @override
  $Res call({Request request, ActiveContextRoot root});
}

/// @nodoc
class __$$IsolateRequestCopyWithImpl<$Res>
    extends _$IsolateMessageCopyWithImpl<$Res>
    implements _$$IsolateRequestCopyWith<$Res> {
  __$$IsolateRequestCopyWithImpl(
      _$IsolateRequest _value, $Res Function(_$IsolateRequest) _then)
      : super(_value, (v) => _then(v as _$IsolateRequest));

  @override
  _$IsolateRequest get _value => super._value as _$IsolateRequest;

  @override
  $Res call({
    Object? request = freezed,
    Object? root = freezed,
  }) {
    return _then(_$IsolateRequest(
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as Request,
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ActiveContextRoot,
    ));
  }
}

/// @nodoc

class _$IsolateRequest extends IsolateRequest {
  const _$IsolateRequest({required this.request, required this.root})
      : super._();

  @override
  final Request request;
  @override
  final ActiveContextRoot root;

  @override
  String toString() {
    return 'IsolateMessage.request(request: $request, root: $root)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsolateRequest &&
            const DeepCollectionEquality().equals(other.request, request) &&
            const DeepCollectionEquality().equals(other.root, root));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(request),
      const DeepCollectionEquality().hash(root));

  @JsonKey(ignore: true)
  @override
  _$$IsolateRequestCopyWith<_$IsolateRequest> get copyWith =>
      __$$IsolateRequestCopyWithImpl<_$IsolateRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Request request, ActiveContextRoot root) request,
    required TResult Function(Response response, ActiveContextRoot root)
        response,
  }) {
    return request(this.request, root);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Request request, ActiveContextRoot root)? request,
    TResult Function(Response response, ActiveContextRoot root)? response,
  }) {
    return request?.call(this.request, root);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Request request, ActiveContextRoot root)? request,
    TResult Function(Response response, ActiveContextRoot root)? response,
    required TResult orElse(),
  }) {
    if (request != null) {
      return request(this.request, root);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IsolateRequest value) request,
    required TResult Function(IsolateResponse value) response,
  }) {
    return request(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(IsolateRequest value)? request,
    TResult Function(IsolateResponse value)? response,
  }) {
    return request?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IsolateRequest value)? request,
    TResult Function(IsolateResponse value)? response,
    required TResult orElse(),
  }) {
    if (request != null) {
      return request(this);
    }
    return orElse();
  }
}

abstract class IsolateRequest extends IsolateMessage {
  const factory IsolateRequest(
      {required final Request request,
      required final ActiveContextRoot root}) = _$IsolateRequest;
  const IsolateRequest._() : super._();

  Request get request;
  @override
  ActiveContextRoot get root;
  @override
  @JsonKey(ignore: true)
  _$$IsolateRequestCopyWith<_$IsolateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IsolateResponseCopyWith<$Res>
    implements $IsolateMessageCopyWith<$Res> {
  factory _$$IsolateResponseCopyWith(
          _$IsolateResponse value, $Res Function(_$IsolateResponse) then) =
      __$$IsolateResponseCopyWithImpl<$Res>;
  @override
  $Res call({Response response, ActiveContextRoot root});
}

/// @nodoc
class __$$IsolateResponseCopyWithImpl<$Res>
    extends _$IsolateMessageCopyWithImpl<$Res>
    implements _$$IsolateResponseCopyWith<$Res> {
  __$$IsolateResponseCopyWithImpl(
      _$IsolateResponse _value, $Res Function(_$IsolateResponse) _then)
      : super(_value, (v) => _then(v as _$IsolateResponse));

  @override
  _$IsolateResponse get _value => super._value as _$IsolateResponse;

  @override
  $Res call({
    Object? response = freezed,
    Object? root = freezed,
  }) {
    return _then(_$IsolateResponse(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Response,
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ActiveContextRoot,
    ));
  }
}

/// @nodoc

class _$IsolateResponse extends IsolateResponse {
  const _$IsolateResponse({required this.response, required this.root})
      : super._();

  @override
  final Response response;
  @override
  final ActiveContextRoot root;

  @override
  String toString() {
    return 'IsolateMessage.response(response: $response, root: $root)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsolateResponse &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality().equals(other.root, root));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(root));

  @JsonKey(ignore: true)
  @override
  _$$IsolateResponseCopyWith<_$IsolateResponse> get copyWith =>
      __$$IsolateResponseCopyWithImpl<_$IsolateResponse>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Request request, ActiveContextRoot root) request,
    required TResult Function(Response response, ActiveContextRoot root)
        response,
  }) {
    return response(this.response, root);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Request request, ActiveContextRoot root)? request,
    TResult Function(Response response, ActiveContextRoot root)? response,
  }) {
    return response?.call(this.response, root);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Request request, ActiveContextRoot root)? request,
    TResult Function(Response response, ActiveContextRoot root)? response,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(this.response, root);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IsolateRequest value) request,
    required TResult Function(IsolateResponse value) response,
  }) {
    return response(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(IsolateRequest value)? request,
    TResult Function(IsolateResponse value)? response,
  }) {
    return response?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IsolateRequest value)? request,
    TResult Function(IsolateResponse value)? response,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(this);
    }
    return orElse();
  }
}

abstract class IsolateResponse extends IsolateMessage {
  const factory IsolateResponse(
      {required final Response response,
      required final ActiveContextRoot root}) = _$IsolateResponse;
  const IsolateResponse._() : super._();

  Response get response;
  @override
  ActiveContextRoot get root;
  @override
  @JsonKey(ignore: true)
  _$$IsolateResponseCopyWith<_$IsolateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
