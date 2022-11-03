// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'log_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LogRecord {
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LogRecordCopyWith<LogRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogRecordCopyWith<$Res> {
  factory $LogRecordCopyWith(LogRecord value, $Res Function(LogRecord) then) =
      _$LogRecordCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$LogRecordCopyWithImpl<$Res> implements $LogRecordCopyWith<$Res> {
  _$LogRecordCopyWithImpl(this._value, this._then);

  final LogRecord _value;
  // ignore: unused_field
  final $Res Function(LogRecord) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LogRecordCopyWith<$Res> implements $LogRecordCopyWith<$Res> {
  factory _$$_LogRecordCopyWith(
          _$_LogRecord value, $Res Function(_$_LogRecord) then) =
      __$$_LogRecordCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$$_LogRecordCopyWithImpl<$Res> extends _$LogRecordCopyWithImpl<$Res>
    implements _$$_LogRecordCopyWith<$Res> {
  __$$_LogRecordCopyWithImpl(
      _$_LogRecord _value, $Res Function(_$_LogRecord) _then)
      : super(_value, (v) => _then(v as _$_LogRecord));

  @override
  _$_LogRecord get _value => super._value as _$_LogRecord;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_LogRecord(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LogRecord extends _LogRecord {
  const _$_LogRecord({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'LogRecord(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LogRecord &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_LogRecordCopyWith<_$_LogRecord> get copyWith =>
      __$$_LogRecordCopyWithImpl<_$_LogRecord>(this, _$identity);
}

abstract class _LogRecord extends LogRecord {
  const factory _LogRecord({required final String message}) = _$_LogRecord;
  const _LogRecord._() : super._();

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_LogRecordCopyWith<_$_LogRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
