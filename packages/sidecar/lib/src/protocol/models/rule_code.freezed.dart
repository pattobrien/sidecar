// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'rule_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RuleCode _$RuleCodeFromJson(Map<String, dynamic> json) {
  return _RuleCode.fromJson(json);
}

/// @nodoc
mixin _$RuleCode {
  RuleType get type => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get packageName => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RuleCodeCopyWith<RuleCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RuleCodeCopyWith<$Res> {
  factory $RuleCodeCopyWith(RuleCode value, $Res Function(RuleCode) then) =
      _$RuleCodeCopyWithImpl<$Res>;
  $Res call({RuleType type, String code, String packageName, String? url});
}

/// @nodoc
class _$RuleCodeCopyWithImpl<$Res> implements $RuleCodeCopyWith<$Res> {
  _$RuleCodeCopyWithImpl(this._value, this._then);

  final RuleCode _value;
  // ignore: unused_field
  final $Res Function(RuleCode) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? code = freezed,
    Object? packageName = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RuleType,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_RuleCodeCopyWith<$Res> implements $RuleCodeCopyWith<$Res> {
  factory _$$_RuleCodeCopyWith(
          _$_RuleCode value, $Res Function(_$_RuleCode) then) =
      __$$_RuleCodeCopyWithImpl<$Res>;
  @override
  $Res call({RuleType type, String code, String packageName, String? url});
}

/// @nodoc
class __$$_RuleCodeCopyWithImpl<$Res> extends _$RuleCodeCopyWithImpl<$Res>
    implements _$$_RuleCodeCopyWith<$Res> {
  __$$_RuleCodeCopyWithImpl(
      _$_RuleCode _value, $Res Function(_$_RuleCode) _then)
      : super(_value, (v) => _then(v as _$_RuleCode));

  @override
  _$_RuleCode get _value => super._value as _$_RuleCode;

  @override
  $Res call({
    Object? type = freezed,
    Object? code = freezed,
    Object? packageName = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_RuleCode(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RuleType,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RuleCode extends _RuleCode {
  const _$_RuleCode(
      {required this.type,
      required this.code,
      required this.packageName,
      this.url})
      : super._();

  factory _$_RuleCode.fromJson(Map<String, dynamic> json) =>
      _$$_RuleCodeFromJson(json);

  @override
  final RuleType type;
  @override
  final String code;
  @override
  final String packageName;
  @override
  final String? url;

  @override
  String toString() {
    return 'RuleCode(type: $type, code: $code, packageName: $packageName, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RuleCode &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$$_RuleCodeCopyWith<_$_RuleCode> get copyWith =>
      __$$_RuleCodeCopyWithImpl<_$_RuleCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RuleCodeToJson(
      this,
    );
  }
}

abstract class _RuleCode extends RuleCode {
  const factory _RuleCode(
      {required final RuleType type,
      required final String code,
      required final String packageName,
      final String? url}) = _$_RuleCode;
  const _RuleCode._() : super._();

  factory _RuleCode.fromJson(Map<String, dynamic> json) = _$_RuleCode.fromJson;

  @override
  RuleType get type;
  @override
  String get code;
  @override
  String get packageName;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$_RuleCodeCopyWith<_$_RuleCode> get copyWith =>
      throw _privateConstructorUsedError;
}
