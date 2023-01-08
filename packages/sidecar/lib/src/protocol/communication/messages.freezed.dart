// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'messages.dart';

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
    case 'log':
      return LogMessage.fromJson(json);

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
    required TResult Function(LogRecord record) log,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SidecarRequest request, String id)? request,
    TResult? Function(SidecarResponse response, String id)? response,
    TResult? Function(SidecarNotification notification)? notification,
    TResult? Function(LogRecord record)? log,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function(LogRecord record)? log,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestMessage value) request,
    required TResult Function(ResponseMessage value) response,
    required TResult Function(NotificationMessage value) notification,
    required TResult Function(LogMessage value) log,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestMessage value)? request,
    TResult? Function(ResponseMessage value)? response,
    TResult? Function(NotificationMessage value)? notification,
    TResult? Function(LogMessage value)? log,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(LogMessage value)? log,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarMessageCopyWith<$Res> {
  factory $SidecarMessageCopyWith(
          SidecarMessage value, $Res Function(SidecarMessage) then) =
      _$SidecarMessageCopyWithImpl<$Res, SidecarMessage>;
}

/// @nodoc
class _$SidecarMessageCopyWithImpl<$Res, $Val extends SidecarMessage>
    implements $SidecarMessageCopyWith<$Res> {
  _$SidecarMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RequestMessageCopyWith<$Res> {
  factory _$$RequestMessageCopyWith(
          _$RequestMessage value, $Res Function(_$RequestMessage) then) =
      __$$RequestMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({SidecarRequest request, String id});

  $SidecarRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$RequestMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res, _$RequestMessage>
    implements _$$RequestMessageCopyWith<$Res> {
  __$$RequestMessageCopyWithImpl(
      _$RequestMessage _value, $Res Function(_$RequestMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
    Object? id = null,
  }) {
    return _then(_$RequestMessage(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SidecarRequest,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.request, request) || other.request == request) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, request, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestMessageCopyWith<_$RequestMessage> get copyWith =>
      __$$RequestMessageCopyWithImpl<_$RequestMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function(LogRecord record) log,
  }) {
    return request(this.request, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SidecarRequest request, String id)? request,
    TResult? Function(SidecarResponse response, String id)? response,
    TResult? Function(SidecarNotification notification)? notification,
    TResult? Function(LogRecord record)? log,
  }) {
    return request?.call(this.request, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function(LogRecord record)? log,
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
    required TResult Function(LogMessage value) log,
  }) {
    return request(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestMessage value)? request,
    TResult? Function(ResponseMessage value)? response,
    TResult? Function(NotificationMessage value)? notification,
    TResult? Function(LogMessage value)? log,
  }) {
    return request?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(LogMessage value)? log,
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
  @useResult
  $Res call({SidecarResponse response, String id});

  $SidecarResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$ResponseMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res, _$ResponseMessage>
    implements _$$ResponseMessageCopyWith<$Res> {
  __$$ResponseMessageCopyWithImpl(
      _$ResponseMessage _value, $Res Function(_$ResponseMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? id = null,
  }) {
    return _then(_$ResponseMessage(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as SidecarResponse,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SidecarResponseCopyWith<$Res> get response {
    return $SidecarResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponseMessage extends ResponseMessage {
  const _$ResponseMessage(this.response,
      {required this.id, final String? $type})
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
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, response, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseMessageCopyWith<_$ResponseMessage> get copyWith =>
      __$$ResponseMessageCopyWithImpl<_$ResponseMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function(LogRecord record) log,
  }) {
    return response(this.response, id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SidecarRequest request, String id)? request,
    TResult? Function(SidecarResponse response, String id)? response,
    TResult? Function(SidecarNotification notification)? notification,
    TResult? Function(LogRecord record)? log,
  }) {
    return response?.call(this.response, id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function(LogRecord record)? log,
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
    required TResult Function(LogMessage value) log,
  }) {
    return response(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestMessage value)? request,
    TResult? Function(ResponseMessage value)? response,
    TResult? Function(NotificationMessage value)? notification,
    TResult? Function(LogMessage value)? log,
  }) {
    return response?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(LogMessage value)? log,
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
  const factory ResponseMessage(final SidecarResponse response,
      {required final String id}) = _$ResponseMessage;
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
  @useResult
  $Res call({SidecarNotification notification});

  $SidecarNotificationCopyWith<$Res> get notification;
}

/// @nodoc
class __$$NotificationMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res, _$NotificationMessage>
    implements _$$NotificationMessageCopyWith<$Res> {
  __$$NotificationMessageCopyWithImpl(
      _$NotificationMessage _value, $Res Function(_$NotificationMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notification = null,
  }) {
    return _then(_$NotificationMessage(
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as SidecarNotification,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.notification, notification) ||
                other.notification == notification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, notification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationMessageCopyWith<_$NotificationMessage> get copyWith =>
      __$$NotificationMessageCopyWithImpl<_$NotificationMessage>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function(LogRecord record) log,
  }) {
    return notification(this.notification);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SidecarRequest request, String id)? request,
    TResult? Function(SidecarResponse response, String id)? response,
    TResult? Function(SidecarNotification notification)? notification,
    TResult? Function(LogRecord record)? log,
  }) {
    return notification?.call(this.notification);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function(LogRecord record)? log,
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
    required TResult Function(LogMessage value) log,
  }) {
    return notification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestMessage value)? request,
    TResult? Function(ResponseMessage value)? response,
    TResult? Function(NotificationMessage value)? notification,
    TResult? Function(LogMessage value)? log,
  }) {
    return notification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(LogMessage value)? log,
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
abstract class _$$LogMessageCopyWith<$Res> {
  factory _$$LogMessageCopyWith(
          _$LogMessage value, $Res Function(_$LogMessage) then) =
      __$$LogMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({LogRecord record});

  $LogRecordCopyWith<$Res> get record;
}

/// @nodoc
class __$$LogMessageCopyWithImpl<$Res>
    extends _$SidecarMessageCopyWithImpl<$Res, _$LogMessage>
    implements _$$LogMessageCopyWith<$Res> {
  __$$LogMessageCopyWithImpl(
      _$LogMessage _value, $Res Function(_$LogMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = null,
  }) {
    return _then(_$LogMessage(
      null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as LogRecord,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $LogRecordCopyWith<$Res> get record {
    return $LogRecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$LogMessage extends LogMessage {
  const _$LogMessage(this.record, {final String? $type})
      : $type = $type ?? 'log',
        super._();

  factory _$LogMessage.fromJson(Map<String, dynamic> json) =>
      _$$LogMessageFromJson(json);

  @override
  final LogRecord record;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SidecarMessage.log(record: $record)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogMessage &&
            (identical(other.record, record) || other.record == record));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, record);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogMessageCopyWith<_$LogMessage> get copyWith =>
      __$$LogMessageCopyWithImpl<_$LogMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SidecarRequest request, String id) request,
    required TResult Function(SidecarResponse response, String id) response,
    required TResult Function(SidecarNotification notification) notification,
    required TResult Function(LogRecord record) log,
  }) {
    return log(record);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SidecarRequest request, String id)? request,
    TResult? Function(SidecarResponse response, String id)? response,
    TResult? Function(SidecarNotification notification)? notification,
    TResult? Function(LogRecord record)? log,
  }) {
    return log?.call(record);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SidecarRequest request, String id)? request,
    TResult Function(SidecarResponse response, String id)? response,
    TResult Function(SidecarNotification notification)? notification,
    TResult Function(LogRecord record)? log,
    required TResult orElse(),
  }) {
    if (log != null) {
      return log(record);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestMessage value) request,
    required TResult Function(ResponseMessage value) response,
    required TResult Function(NotificationMessage value) notification,
    required TResult Function(LogMessage value) log,
  }) {
    return log(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestMessage value)? request,
    TResult? Function(ResponseMessage value)? response,
    TResult? Function(NotificationMessage value)? notification,
    TResult? Function(LogMessage value)? log,
  }) {
    return log?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestMessage value)? request,
    TResult Function(ResponseMessage value)? response,
    TResult Function(NotificationMessage value)? notification,
    TResult Function(LogMessage value)? log,
    required TResult orElse(),
  }) {
    if (log != null) {
      return log(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LogMessageToJson(
      this,
    );
  }
}

abstract class LogMessage extends SidecarMessage {
  const factory LogMessage(final LogRecord record) = _$LogMessage;
  const LogMessage._() : super._();

  factory LogMessage.fromJson(Map<String, dynamic> json) =
      _$LogMessage.fromJson;

  LogRecord get record;
  @JsonKey(ignore: true)
  _$$LogMessageCopyWith<_$LogMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
