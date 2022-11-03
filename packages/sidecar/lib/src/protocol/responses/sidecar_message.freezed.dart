// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sidecar_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarMessage _$SidecarMessageFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'request':
      return RequestMessage.fromJson(json);
    case 'response':
      return ResponseMessage.fromJson(json);
    case 'notification':
      return NotificationMessage.fromJson(json);
    case 'error':
      return ErrorMessage.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SidecarMessage',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SidecarMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestMessage value) request,
    required TResult Function(ResponseMessage value) response,
    required TResult Function(NotificationMessage value) notification,
    required TResult Function(ErrorMessage value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarMessageCopyWith<$Res> {
  factory $SidecarMessageCopyWith(
          SidecarMessage value, $Res Function(SidecarMessage) then) =
      _$SidecarMessageCopyWithImpl<$Res>;
}

/// @nodoc
class _$SidecarMessageCopyWithImpl<$Res>
    implements $SidecarMessageCopyWith<$Res> {
  _$SidecarMessageCopyWithImpl(this._value, this._then);

  final SidecarMessage _value;
  // ignore: unused_field
  final $Res Function(SidecarMessage) _then;
}

/// @nodoc
abstract class _$$RequestMessageCopyWith<$Res> {
  factory _$$RequestMessageCopyWith(
          _$RequestMessage value, $Res Function(_$RequestMessage) then) =
      __$$RequestMessageCopyWithImpl<$Res>;
  $Res call({SidecarRequest request, String id});

  $SidecarRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$RequestMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res>
    implements _$$RequestMessageCopyWith<$Res> {
  __$$RequestMessageCopyWithImpl(
      _$RequestMessage _value, $Res Function(_$RequestMessage) _then)
      : super(_value, (v) => _then(v as _$RequestMessage));

  @override
  _$RequestMessage get _value => super._value as _$RequestMessage;

  @override
  $Res call({
    Object? request = freezed,
    Object? id = freezed,
  }) {
    return _then(_$RequestMessage(
      request: request == freezed
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SidecarRequest,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $SidecarRequestCopyWith<$Res> get request {
    return $SidecarRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestMessage extends RequestMessage {
  const _$RequestMessage(
      {required this.request, required this.id, final String? $type})
      : $type = $type ?? 'request',
        super._();

  factory _$RequestMessage.fromJson(Map<String, dynamic> json) =>
      _$$RequestMessageFromJson(json);

  @override
  final SidecarRequest request;
  @override
  final String id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarMessage.request(request: $request, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestMessage &&
            const DeepCollectionEquality().equals(other.request, request) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(request),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$RequestMessageCopyWith<_$RequestMessage> get copyWith =>
      __$$RequestMessageCopyWithImpl<_$RequestMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function() error,
  }) {
    return request(this.request, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
  }) {
    return request?.call(this.request, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (request != null) {
      return request(this.request, id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestMessage value) request,
    required TResult Function(ResponseMessage value) response,
    required TResult Function(NotificationMessage value) notification,
    required TResult Function(ErrorMessage value) error,
  }) {
    return request(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
  }) {
    return request?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
    required TResult orElse(),
  }) {
    if (request != null) {
      return request(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestMessageToJson(
      this,
    );
  }
}

abstract class RequestMessage extends SidecarMessage {
  const factory RequestMessage(
      {required final SidecarRequest request,
      required final String id}) = _$RequestMessage;
  const RequestMessage._() : super._();

  factory RequestMessage.fromJson(Map<String, dynamic> json) =
      _$RequestMessage.fromJson;

  SidecarRequest get request;
  String get id;
  @JsonKey(ignore: true)
  _$$RequestMessageCopyWith<_$RequestMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResponseMessageCopyWith<$Res> {
  factory _$$ResponseMessageCopyWith(
          _$ResponseMessage value, $Res Function(_$ResponseMessage) then) =
      __$$ResponseMessageCopyWithImpl<$Res>;
  $Res call({SidecarResponse response, String id});

  $SidecarResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$ResponseMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res>
    implements _$$ResponseMessageCopyWith<$Res> {
  __$$ResponseMessageCopyWithImpl(
      _$ResponseMessage _value, $Res Function(_$ResponseMessage) _then)
      : super(_value, (v) => _then(v as _$ResponseMessage));

  @override
  _$ResponseMessage get _value => super._value as _$ResponseMessage;

  @override
  $Res call({
    Object? response = freezed,
    Object? id = freezed,
  }) {
    return _then(_$ResponseMessage(
      response: response == freezed
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as SidecarResponse,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $SidecarResponseCopyWith<$Res> get response {
    return $SidecarResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponseMessage extends ResponseMessage {
  const _$ResponseMessage(
      {required this.response, required this.id, final String? $type})
      : $type = $type ?? 'response',
        super._();

  factory _$ResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$$ResponseMessageFromJson(json);

  @override
  final SidecarResponse response;
  @override
  final String id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarMessage.response(response: $response, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseMessage &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$ResponseMessageCopyWith<_$ResponseMessage> get copyWith =>
      __$$ResponseMessageCopyWithImpl<_$ResponseMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function() error,
  }) {
    return response(this.response, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
  }) {
    return response?.call(this.response, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(this.response, id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestMessage value) request,
    required TResult Function(ResponseMessage value) response,
    required TResult Function(NotificationMessage value) notification,
    required TResult Function(ErrorMessage value) error,
  }) {
    return response(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
  }) {
    return response?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponseMessageToJson(
      this,
    );
  }
}

abstract class ResponseMessage extends SidecarMessage {
  const factory ResponseMessage(
      {required final SidecarResponse response,
      required final String id}) = _$ResponseMessage;
  const ResponseMessage._() : super._();

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =
      _$ResponseMessage.fromJson;

  SidecarResponse get response;
  String get id;
  @JsonKey(ignore: true)
  _$$ResponseMessageCopyWith<_$ResponseMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotificationMessageCopyWith<$Res> {
  factory _$$NotificationMessageCopyWith(_$NotificationMessage value,
          $Res Function(_$NotificationMessage) then) =
      __$$NotificationMessageCopyWithImpl<$Res>;
  $Res call({SidecarNotification notification});

  $SidecarNotificationCopyWith<$Res> get notification;
}

/// @nodoc
class __$$NotificationMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res>
    implements _$$NotificationMessageCopyWith<$Res> {
  __$$NotificationMessageCopyWithImpl(
      _$NotificationMessage _value, $Res Function(_$NotificationMessage) _then)
      : super(_value, (v) => _then(v as _$NotificationMessage));

  @override
  _$NotificationMessage get _value => super._value as _$NotificationMessage;

  @override
  $Res call({
    Object? notification = freezed,
  }) {
    return _then(_$NotificationMessage(
      notification: notification == freezed
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as SidecarNotification,
    ));
  }

  @override
  $SidecarNotificationCopyWith<$Res> get notification {
    return $SidecarNotificationCopyWith<$Res>(_value.notification, (value) {
      return _then(_value.copyWith(notification: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationMessage extends NotificationMessage {
  const _$NotificationMessage({required this.notification, final String? $type})
      : $type = $type ?? 'notification',
        super._();

  factory _$NotificationMessage.fromJson(Map<String, dynamic> json) =>
      _$$NotificationMessageFromJson(json);

  @override
  final SidecarNotification notification;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarMessage.notification(notification: $notification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationMessage &&
            const DeepCollectionEquality()
                .equals(other.notification, notification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(notification));

  @JsonKey(ignore: true)
  @override
  _$$NotificationMessageCopyWith<_$NotificationMessage> get copyWith =>
      __$$NotificationMessageCopyWithImpl<_$NotificationMessage>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function() error,
  }) {
    return notification(this.notification);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
  }) {
    return notification?.call(this.notification);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (notification != null) {
      return notification(this.notification);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestMessage value) request,
    required TResult Function(ResponseMessage value) response,
    required TResult Function(NotificationMessage value) notification,
    required TResult Function(ErrorMessage value) error,
  }) {
    return notification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
  }) {
    return notification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
    required TResult orElse(),
  }) {
    if (notification != null) {
      return notification(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationMessageToJson(
      this,
    );
  }
}

abstract class NotificationMessage extends SidecarMessage {
  const factory NotificationMessage(
          {required final SidecarNotification notification}) =
      _$NotificationMessage;
  const NotificationMessage._() : super._();

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =
      _$NotificationMessage.fromJson;

  SidecarNotification get notification;
  @JsonKey(ignore: true)
  _$$NotificationMessageCopyWith<_$NotificationMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorMessageCopyWith<$Res> {
  factory _$$ErrorMessageCopyWith(
          _$ErrorMessage value, $Res Function(_$ErrorMessage) then) =
      __$$ErrorMessageCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ErrorMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res>
    implements _$$ErrorMessageCopyWith<$Res> {
  __$$ErrorMessageCopyWithImpl(
      _$ErrorMessage _value, $Res Function(_$ErrorMessage) _then)
      : super(_value, (v) => _then(v as _$ErrorMessage));

  @override
  _$ErrorMessage get _value => super._value as _$ErrorMessage;
}

/// @nodoc
@JsonSerializable()
class _$ErrorMessage extends ErrorMessage {
  const _$ErrorMessage({final String? $type})
      : $type = $type ?? 'error',
        super._();

  factory _$ErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$$ErrorMessageFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarMessage.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ErrorMessage);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestMessage value) request,
    required TResult Function(ResponseMessage value) response,
    required TResult Function(NotificationMessage value) notification,
    required TResult Function(ErrorMessage value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(ErrorMessage value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorMessageToJson(
      this,
    );
  }
}

abstract class ErrorMessage extends SidecarMessage {
  const factory ErrorMessage() = _$ErrorMessage;
  const ErrorMessage._() : super._();

  factory ErrorMessage.fromJson(Map<String, dynamic> json) =
      _$ErrorMessage.fromJson;
}
