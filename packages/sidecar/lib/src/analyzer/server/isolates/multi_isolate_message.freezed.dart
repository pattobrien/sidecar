// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'multi_isolate_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MultiIsolateMessage {
  Request get originalRequest => throw _privateConstructorUsedError;
  DateTime get initialTimestamp => throw _privateConstructorUsedError;
  List<IsolateRequest> get requests => throw _privateConstructorUsedError;
  List<IsolateResponse> get responses => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MultiIsolateMessageCopyWith<MultiIsolateMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiIsolateMessageCopyWith<$Res> {
  factory $MultiIsolateMessageCopyWith(
          MultiIsolateMessage value, $Res Function(MultiIsolateMessage) then) =
      _$MultiIsolateMessageCopyWithImpl<$Res>;
  $Res call(
      {Request originalRequest,
      DateTime initialTimestamp,
      List<IsolateRequest> requests,
      List<IsolateResponse> responses});
}

/// @nodoc
class _$MultiIsolateMessageCopyWithImpl<$Res>
    implements $MultiIsolateMessageCopyWith<$Res> {
  _$MultiIsolateMessageCopyWithImpl(this._value, this._then);

  final MultiIsolateMessage _value;
  // ignore: unused_field
  final $Res Function(MultiIsolateMessage) _then;

  @override
  $Res call({
    Object? originalRequest = freezed,
    Object? initialTimestamp = freezed,
    Object? requests = freezed,
    Object? responses = freezed,
  }) {
    return _then(_value.copyWith(
      originalRequest: originalRequest == freezed
          ? _value.originalRequest
          : originalRequest // ignore: cast_nullable_to_non_nullable
              as Request,
      initialTimestamp: initialTimestamp == freezed
          ? _value.initialTimestamp
          : initialTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requests: requests == freezed
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<IsolateRequest>,
      responses: responses == freezed
          ? _value.responses
          : responses // ignore: cast_nullable_to_non_nullable
              as List<IsolateResponse>,
    ));
  }
}

/// @nodoc
abstract class _$$_MultiIsolateReponseCopyWith<$Res>
    implements $MultiIsolateMessageCopyWith<$Res> {
  factory _$$_MultiIsolateReponseCopyWith(_$_MultiIsolateReponse value,
          $Res Function(_$_MultiIsolateReponse) then) =
      __$$_MultiIsolateReponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {Request originalRequest,
      DateTime initialTimestamp,
      List<IsolateRequest> requests,
      List<IsolateResponse> responses});
}

/// @nodoc
class __$$_MultiIsolateReponseCopyWithImpl<$Res>
    extends _$MultiIsolateMessageCopyWithImpl<$Res>
    implements _$$_MultiIsolateReponseCopyWith<$Res> {
  __$$_MultiIsolateReponseCopyWithImpl(_$_MultiIsolateReponse _value,
      $Res Function(_$_MultiIsolateReponse) _then)
      : super(_value, (v) => _then(v as _$_MultiIsolateReponse));

  @override
  _$_MultiIsolateReponse get _value => super._value as _$_MultiIsolateReponse;

  @override
  $Res call({
    Object? originalRequest = freezed,
    Object? initialTimestamp = freezed,
    Object? requests = freezed,
    Object? responses = freezed,
  }) {
    return _then(_$_MultiIsolateReponse(
      originalRequest: originalRequest == freezed
          ? _value.originalRequest
          : originalRequest // ignore: cast_nullable_to_non_nullable
              as Request,
      initialTimestamp: initialTimestamp == freezed
          ? _value.initialTimestamp
          : initialTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requests: requests == freezed
          ? _value._requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<IsolateRequest>,
      responses: responses == freezed
          ? _value._responses
          : responses // ignore: cast_nullable_to_non_nullable
              as List<IsolateResponse>,
    ));
  }
}

/// @nodoc

class _$_MultiIsolateReponse extends _MultiIsolateReponse {
  const _$_MultiIsolateReponse(
      {required this.originalRequest,
      required this.initialTimestamp,
      required final List<IsolateRequest> requests,
      final List<IsolateResponse> responses = const <IsolateResponse>[]})
      : _requests = requests,
        _responses = responses,
        super._();

  @override
  final Request originalRequest;
  @override
  final DateTime initialTimestamp;
  final List<IsolateRequest> _requests;
  @override
  List<IsolateRequest> get requests {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  final List<IsolateResponse> _responses;
  @override
  @JsonKey()
  List<IsolateResponse> get responses {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_responses);
  }

  @override
  String toString() {
    return 'MultiIsolateMessage(originalRequest: $originalRequest, initialTimestamp: $initialTimestamp, requests: $requests, responses: $responses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MultiIsolateReponse &&
            const DeepCollectionEquality()
                .equals(other.originalRequest, originalRequest) &&
            const DeepCollectionEquality()
                .equals(other.initialTimestamp, initialTimestamp) &&
            const DeepCollectionEquality().equals(other._requests, _requests) &&
            const DeepCollectionEquality()
                .equals(other._responses, _responses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(originalRequest),
      const DeepCollectionEquality().hash(initialTimestamp),
      const DeepCollectionEquality().hash(_requests),
      const DeepCollectionEquality().hash(_responses));

  @JsonKey(ignore: true)
  @override
  _$$_MultiIsolateReponseCopyWith<_$_MultiIsolateReponse> get copyWith =>
      __$$_MultiIsolateReponseCopyWithImpl<_$_MultiIsolateReponse>(
          this, _$identity);
}

abstract class _MultiIsolateReponse extends MultiIsolateMessage {
  const factory _MultiIsolateReponse(
      {required final Request originalRequest,
      required final DateTime initialTimestamp,
      required final List<IsolateRequest> requests,
      final List<IsolateResponse> responses}) = _$_MultiIsolateReponse;
  const _MultiIsolateReponse._() : super._();

  @override
  Request get originalRequest;
  @override
  DateTime get initialTimestamp;
  @override
  List<IsolateRequest> get requests;
  @override
  List<IsolateResponse> get responses;
  @override
  @JsonKey(ignore: true)
  _$$_MultiIsolateReponseCopyWith<_$_MultiIsolateReponse> get copyWith =>
      throw _privateConstructorUsedError;
}
