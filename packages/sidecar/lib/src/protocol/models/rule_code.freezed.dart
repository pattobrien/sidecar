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
  switch (json['runtimeType']) {
    case 'lint':
      return LintCode.fromJson(json);
    case 'assist':
      return AssistCode.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'RuleCode',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RuleCode {
  String get code => throw _privateConstructorUsedError;
  String get package => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code, String package, String? url) lint,
    required TResult Function(String code, String package, String? url) assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String code, String package, String? url)? lint,
    TResult Function(String code, String package, String? url)? assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code, String package, String? url)? lint,
    TResult Function(String code, String package, String? url)? assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintCode value) lint,
    required TResult Function(AssistCode value) assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintCode value)? lint,
    TResult Function(AssistCode value)? assist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintCode value)? lint,
    TResult Function(AssistCode value)? assist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RuleCodeCopyWith<RuleCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RuleCodeCopyWith<$Res> {
  factory $RuleCodeCopyWith(RuleCode value, $Res Function(RuleCode) then) =
      _$RuleCodeCopyWithImpl<$Res>;
  $Res call({String code, String package, String? url});
}

/// @nodoc
class _$RuleCodeCopyWithImpl<$Res> implements $RuleCodeCopyWith<$Res> {
  _$RuleCodeCopyWithImpl(this._value, this._then);

  final RuleCode _value;
  // ignore: unused_field
  final $Res Function(RuleCode) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? package = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$LintCodeCopyWith<$Res> implements $RuleCodeCopyWith<$Res> {
  factory _$$LintCodeCopyWith(
          _$LintCode value, $Res Function(_$LintCode) then) =
      __$$LintCodeCopyWithImpl<$Res>;
  @override
  $Res call({String code, String package, String? url});
}

/// @nodoc
class __$$LintCodeCopyWithImpl<$Res> extends _$RuleCodeCopyWithImpl<$Res>
    implements _$$LintCodeCopyWith<$Res> {
  __$$LintCodeCopyWithImpl(_$LintCode _value, $Res Function(_$LintCode) _then)
      : super(_value, (v) => _then(v as _$LintCode));

  @override
  _$LintCode get _value => super._value as _$LintCode;

  @override
  $Res call({
    Object? code = freezed,
    Object? package = freezed,
    Object? url = freezed,
  }) {
    return _then(_$LintCode(
      code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
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
class _$LintCode extends LintCode {
  const _$LintCode(this.code,
      {required this.package, this.url, final String? $type})
      : $type = $type ?? 'lint',
        super._();

  factory _$LintCode.fromJson(Map<String, dynamic> json) =>
      _$$LintCodeFromJson(json);

  @override
  final String code;
  @override
  final String package;
  @override
  final String? url;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RuleCode.lint(code: $code, package: $package, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LintCode &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.package, package) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(package),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$$LintCodeCopyWith<_$LintCode> get copyWith =>
      __$$LintCodeCopyWithImpl<_$LintCode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code, String package, String? url) lint,
    required TResult Function(String code, String package, String? url) assist,
  }) {
    return lint(code, package, url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String code, String package, String? url)? lint,
    TResult Function(String code, String package, String? url)? assist,
  }) {
    return lint?.call(code, package, url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code, String package, String? url)? lint,
    TResult Function(String code, String package, String? url)? assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(code, package, url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintCode value) lint,
    required TResult Function(AssistCode value) assist,
  }) {
    return lint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintCode value)? lint,
    TResult Function(AssistCode value)? assist,
  }) {
    return lint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintCode value)? lint,
    TResult Function(AssistCode value)? assist,
    required TResult orElse(),
  }) {
    if (lint != null) {
      return lint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LintCodeToJson(
      this,
    );
  }
}

abstract class LintCode extends RuleCode {
  const factory LintCode(final String code,
      {required final String package, final String? url}) = _$LintCode;
  const LintCode._() : super._();

  factory LintCode.fromJson(Map<String, dynamic> json) = _$LintCode.fromJson;

  @override
  String get code;
  @override
  String get package;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$LintCodeCopyWith<_$LintCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssistCodeCopyWith<$Res> implements $RuleCodeCopyWith<$Res> {
  factory _$$AssistCodeCopyWith(
          _$AssistCode value, $Res Function(_$AssistCode) then) =
      __$$AssistCodeCopyWithImpl<$Res>;
  @override
  $Res call({String code, String package, String? url});
}

/// @nodoc
class __$$AssistCodeCopyWithImpl<$Res> extends _$RuleCodeCopyWithImpl<$Res>
    implements _$$AssistCodeCopyWith<$Res> {
  __$$AssistCodeCopyWithImpl(
      _$AssistCode _value, $Res Function(_$AssistCode) _then)
      : super(_value, (v) => _then(v as _$AssistCode));

  @override
  _$AssistCode get _value => super._value as _$AssistCode;

  @override
  $Res call({
    Object? code = freezed,
    Object? package = freezed,
    Object? url = freezed,
  }) {
    return _then(_$AssistCode(
      code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
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
class _$AssistCode extends AssistCode {
  const _$AssistCode(this.code,
      {required this.package, this.url, final String? $type})
      : $type = $type ?? 'assist',
        super._();

  factory _$AssistCode.fromJson(Map<String, dynamic> json) =>
      _$$AssistCodeFromJson(json);

  @override
  final String code;
  @override
  final String package;
  @override
  final String? url;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RuleCode.assist(code: $code, package: $package, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistCode &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.package, package) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(package),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$$AssistCodeCopyWith<_$AssistCode> get copyWith =>
      __$$AssistCodeCopyWithImpl<_$AssistCode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code, String package, String? url) lint,
    required TResult Function(String code, String package, String? url) assist,
  }) {
    return assist(code, package, url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String code, String package, String? url)? lint,
    TResult Function(String code, String package, String? url)? assist,
  }) {
    return assist?.call(code, package, url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code, String package, String? url)? lint,
    TResult Function(String code, String package, String? url)? assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(code, package, url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LintCode value) lint,
    required TResult Function(AssistCode value) assist,
  }) {
    return assist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LintCode value)? lint,
    TResult Function(AssistCode value)? assist,
  }) {
    return assist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LintCode value)? lint,
    TResult Function(AssistCode value)? assist,
    required TResult orElse(),
  }) {
    if (assist != null) {
      return assist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistCodeToJson(
      this,
    );
  }
}

abstract class AssistCode extends RuleCode {
  const factory AssistCode(final String code,
      {required final String package, final String? url}) = _$AssistCode;
  const AssistCode._() : super._();

  factory AssistCode.fromJson(Map<String, dynamic> json) =
      _$AssistCode.fromJson;

  @override
  String get code;
  @override
  String get package;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$AssistCodeCopyWith<_$AssistCode> get copyWith =>
      throw _privateConstructorUsedError;
}
