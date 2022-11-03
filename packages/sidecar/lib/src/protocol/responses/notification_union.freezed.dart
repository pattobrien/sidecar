// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarNotification _$SidecarNotificationFromJson(Map<String, dynamic> json) {
  return InitCompleteNotification.fromJson(json);
}

/// @nodoc
mixin _$SidecarNotification {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initComplete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitCompleteNotification value) initComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarNotificationCopyWith<$Res> {
  factory $SidecarNotificationCopyWith(
          SidecarNotification value, $Res Function(SidecarNotification) then) =
      _$SidecarNotificationCopyWithImpl<$Res>;
}

/// @nodoc
class _$SidecarNotificationCopyWithImpl<$Res>
    implements $SidecarNotificationCopyWith<$Res> {
  _$SidecarNotificationCopyWithImpl(this._value, this._then);

  final SidecarNotification _value;
  // ignore: unused_field
  final $Res Function(SidecarNotification) _then;
}

/// @nodoc
abstract class _$$InitCompleteNotificationCopyWith<$Res> {
  factory _$$InitCompleteNotificationCopyWith(_$InitCompleteNotification value,
          $Res Function(_$InitCompleteNotification) then) =
      __$$InitCompleteNotificationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitCompleteNotificationCopyWithImpl<$Res>
    extends _$SidecarNotificationCopyWithImpl<$Res>
    implements _$$InitCompleteNotificationCopyWith<$Res> {
  __$$InitCompleteNotificationCopyWithImpl(_$InitCompleteNotification _value,
      $Res Function(_$InitCompleteNotification) _then)
      : super(_value, (v) => _then(v as _$InitCompleteNotification));

  @override
  _$InitCompleteNotification get _value =>
      super._value as _$InitCompleteNotification;
}

/// @nodoc
@JsonSerializable()
class _$InitCompleteNotification extends InitCompleteNotification {
  const _$InitCompleteNotification() : super._();

  factory _$InitCompleteNotification.fromJson(Map<String, dynamic> json) =>
      _$$InitCompleteNotificationFromJson(json);

  @override
  String toString() {
    return 'SidecarNotification.initComplete()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitCompleteNotification);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initComplete,
  }) {
    return initComplete();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initComplete,
  }) {
    return initComplete?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initComplete,
    required TResult orElse(),
  }) {
    if (initComplete != null) {
      return initComplete();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitCompleteNotification value) initComplete,
  }) {
    return initComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
  }) {
    return initComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitCompleteNotification value)? initComplete,
    required TResult orElse(),
  }) {
    if (initComplete != null) {
      return initComplete(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InitCompleteNotificationToJson(
      this,
    );
  }
}

abstract class InitCompleteNotification extends SidecarNotification {
  const factory InitCompleteNotification() = _$InitCompleteNotification;
  const InitCompleteNotification._() : super._();

  factory InitCompleteNotification.fromJson(Map<String, dynamic> json) =
      _$InitCompleteNotification.fromJson;
}
