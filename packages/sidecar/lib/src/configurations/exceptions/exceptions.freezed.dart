// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarNewException _$SidecarNewExceptionFromJson(Map<String, dynamic> json) {
  return _SidecarException.fromJson(json);
}

/// @nodoc
mixin _$SidecarNewException {
  RuleCode get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get correction => throw _privateConstructorUsedError;
  @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
  SourceSpan get sourceSpan => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SidecarNewExceptionCopyWith<SidecarNewException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarNewExceptionCopyWith<$Res> {
  factory $SidecarNewExceptionCopyWith(
          SidecarNewException value, $Res Function(SidecarNewException) then) =
      _$SidecarNewExceptionCopyWithImpl<$Res, SidecarNewException>;
  @useResult
  $Res call(
      {RuleCode code,
      String message,
      String? correction,
      @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
          SourceSpan sourceSpan});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class _$SidecarNewExceptionCopyWithImpl<$Res, $Val extends SidecarNewException>
    implements $SidecarNewExceptionCopyWith<$Res> {
  _$SidecarNewExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? correction = freezed,
    Object? sourceSpan = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      correction: freezed == correction
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceSpan: null == sourceSpan
          ? _value.sourceSpan
          : sourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RuleCodeCopyWith<$Res> get code {
    return $RuleCodeCopyWith<$Res>(_value.code, (value) {
      return _then(_value.copyWith(code: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SidecarExceptionCopyWith<$Res>
    implements $SidecarNewExceptionCopyWith<$Res> {
  factory _$$_SidecarExceptionCopyWith(
          _$_SidecarException value, $Res Function(_$_SidecarException) then) =
      __$$_SidecarExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RuleCode code,
      String message,
      String? correction,
      @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
          SourceSpan sourceSpan});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$_SidecarExceptionCopyWithImpl<$Res>
    extends _$SidecarNewExceptionCopyWithImpl<$Res, _$_SidecarException>
    implements _$$_SidecarExceptionCopyWith<$Res> {
  __$$_SidecarExceptionCopyWithImpl(
      _$_SidecarException _value, $Res Function(_$_SidecarException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? correction = freezed,
    Object? sourceSpan = null,
  }) {
    return _then(_$_SidecarException(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      correction: freezed == correction
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceSpan: null == sourceSpan
          ? _value.sourceSpan
          : sourceSpan // ignore: cast_nullable_to_non_nullable
              as SourceSpan,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SidecarException extends _SidecarException {
  const _$_SidecarException(
      {required this.code,
      required this.message,
      this.correction,
      @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
          required this.sourceSpan})
      : super._();

  factory _$_SidecarException.fromJson(Map<String, dynamic> json) =>
      _$$_SidecarExceptionFromJson(json);

  @override
  final RuleCode code;
  @override
  final String message;
  @override
  final String? correction;
  @override
  @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
  final SourceSpan sourceSpan;

  @override
  String toString() {
    return 'SidecarNewException(code: $code, message: $message, correction: $correction, sourceSpan: $sourceSpan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SidecarException &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.correction, correction) ||
                other.correction == correction) &&
            (identical(other.sourceSpan, sourceSpan) ||
                other.sourceSpan == sourceSpan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, code, message, correction, sourceSpan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SidecarExceptionCopyWith<_$_SidecarException> get copyWith =>
      __$$_SidecarExceptionCopyWithImpl<_$_SidecarException>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SidecarExceptionToJson(
      this,
    );
  }
}

abstract class _SidecarException extends SidecarNewException {
  const factory _SidecarException(
      {required final RuleCode code,
      required final String message,
      final String? correction,
      @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
          required final SourceSpan sourceSpan}) = _$_SidecarException;
  const _SidecarException._() : super._();

  factory _SidecarException.fromJson(Map<String, dynamic> json) =
      _$_SidecarException.fromJson;

  @override
  RuleCode get code;
  @override
  String get message;
  @override
  String? get correction;
  @override
  @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
  SourceSpan get sourceSpan;
  @override
  @JsonKey(ignore: true)
  _$$_SidecarExceptionCopyWith<_$_SidecarException> get copyWith =>
      throw _privateConstructorUsedError;
}
