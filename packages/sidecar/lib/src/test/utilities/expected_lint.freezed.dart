// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expected_lint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExpectedLint {
  RuleCode get code => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;
  int get length => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpectedLintCopyWith<ExpectedLint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpectedLintCopyWith<$Res> {
  factory $ExpectedLintCopyWith(
          ExpectedLint value, $Res Function(ExpectedLint) then) =
      _$ExpectedLintCopyWithImpl<$Res>;
  $Res call({RuleCode code, int offset, int length});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class _$ExpectedLintCopyWithImpl<$Res> implements $ExpectedLintCopyWith<$Res> {
  _$ExpectedLintCopyWithImpl(this._value, this._then);

  final ExpectedLint _value;
  // ignore: unused_field
  final $Res Function(ExpectedLint) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? offset = freezed,
    Object? length = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $RuleCodeCopyWith<$Res> get code {
    return $RuleCodeCopyWith<$Res>(_value.code, (value) {
      return _then(_value.copyWith(code: value));
    });
  }
}

/// @nodoc
abstract class _$$_ExpectedLintCopyWith<$Res>
    implements $ExpectedLintCopyWith<$Res> {
  factory _$$_ExpectedLintCopyWith(
          _$_ExpectedLint value, $Res Function(_$_ExpectedLint) then) =
      __$$_ExpectedLintCopyWithImpl<$Res>;
  @override
  $Res call({RuleCode code, int offset, int length});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$_ExpectedLintCopyWithImpl<$Res>
    extends _$ExpectedLintCopyWithImpl<$Res>
    implements _$$_ExpectedLintCopyWith<$Res> {
  __$$_ExpectedLintCopyWithImpl(
      _$_ExpectedLint _value, $Res Function(_$_ExpectedLint) _then)
      : super(_value, (v) => _then(v as _$_ExpectedLint));

  @override
  _$_ExpectedLint get _value => super._value as _$_ExpectedLint;

  @override
  $Res call({
    Object? code = freezed,
    Object? offset = freezed,
    Object? length = freezed,
  }) {
    return _then(_$_ExpectedLint(
      code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ExpectedLint extends _ExpectedLint {
  const _$_ExpectedLint(this.code, this.offset, this.length) : super._();

  @override
  final RuleCode code;
  @override
  final int offset;
  @override
  final int length;

  @override
  String toString() {
    return 'ExpectedLint(code: $code, offset: $offset, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpectedLint &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.length, length));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(length));

  @JsonKey(ignore: true)
  @override
  _$$_ExpectedLintCopyWith<_$_ExpectedLint> get copyWith =>
      __$$_ExpectedLintCopyWithImpl<_$_ExpectedLint>(this, _$identity);
}

abstract class _ExpectedLint extends ExpectedLint {
  const factory _ExpectedLint(
          final RuleCode code, final int offset, final int length) =
      _$_ExpectedLint;
  const _ExpectedLint._() : super._();

  @override
  RuleCode get code;
  @override
  int get offset;
  @override
  int get length;
  @override
  @JsonKey(ignore: true)
  _$$_ExpectedLintCopyWith<_$_ExpectedLint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpectedText {
  String get text => throw _privateConstructorUsedError;
  int? get offset => throw _privateConstructorUsedError;
  int? get length => throw _privateConstructorUsedError;
  int? get startLine => throw _privateConstructorUsedError;
  int? get startColumn => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpectedTextCopyWith<ExpectedText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpectedTextCopyWith<$Res> {
  factory $ExpectedTextCopyWith(
          ExpectedText value, $Res Function(ExpectedText) then) =
      _$ExpectedTextCopyWithImpl<$Res>;
  $Res call(
      {String text,
      int? offset,
      int? length,
      int? startLine,
      int? startColumn});
}

/// @nodoc
class _$ExpectedTextCopyWithImpl<$Res> implements $ExpectedTextCopyWith<$Res> {
  _$ExpectedTextCopyWithImpl(this._value, this._then);

  final ExpectedText _value;
  // ignore: unused_field
  final $Res Function(ExpectedText) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? offset = freezed,
    Object? length = freezed,
    Object? startLine = freezed,
    Object? startColumn = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      startLine: startLine == freezed
          ? _value.startLine
          : startLine // ignore: cast_nullable_to_non_nullable
              as int?,
      startColumn: startColumn == freezed
          ? _value.startColumn
          : startColumn // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_ExpectedTextCopyWith<$Res>
    implements $ExpectedTextCopyWith<$Res> {
  factory _$$_ExpectedTextCopyWith(
          _$_ExpectedText value, $Res Function(_$_ExpectedText) then) =
      __$$_ExpectedTextCopyWithImpl<$Res>;
  @override
  $Res call(
      {String text,
      int? offset,
      int? length,
      int? startLine,
      int? startColumn});
}

/// @nodoc
class __$$_ExpectedTextCopyWithImpl<$Res>
    extends _$ExpectedTextCopyWithImpl<$Res>
    implements _$$_ExpectedTextCopyWith<$Res> {
  __$$_ExpectedTextCopyWithImpl(
      _$_ExpectedText _value, $Res Function(_$_ExpectedText) _then)
      : super(_value, (v) => _then(v as _$_ExpectedText));

  @override
  _$_ExpectedText get _value => super._value as _$_ExpectedText;

  @override
  $Res call({
    Object? text = freezed,
    Object? offset = freezed,
    Object? length = freezed,
    Object? startLine = freezed,
    Object? startColumn = freezed,
  }) {
    return _then(_$_ExpectedText(
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      startLine: startLine == freezed
          ? _value.startLine
          : startLine // ignore: cast_nullable_to_non_nullable
              as int?,
      startColumn: startColumn == freezed
          ? _value.startColumn
          : startColumn // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_ExpectedText extends _ExpectedText {
  _$_ExpectedText(this.text,
      {this.offset, this.length, this.startLine, this.startColumn})
      : super._();

  @override
  final String text;
  @override
  final int? offset;
  @override
  final int? length;
  @override
  final int? startLine;
  @override
  final int? startColumn;

  @override
  String toString() {
    return 'ExpectedText(text: $text, offset: $offset, length: $length, startLine: $startLine, startColumn: $startColumn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpectedText &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.length, length) &&
            const DeepCollectionEquality().equals(other.startLine, startLine) &&
            const DeepCollectionEquality()
                .equals(other.startColumn, startColumn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(length),
      const DeepCollectionEquality().hash(startLine),
      const DeepCollectionEquality().hash(startColumn));

  @JsonKey(ignore: true)
  @override
  _$$_ExpectedTextCopyWith<_$_ExpectedText> get copyWith =>
      __$$_ExpectedTextCopyWithImpl<_$_ExpectedText>(this, _$identity);
}

abstract class _ExpectedText extends ExpectedText {
  factory _ExpectedText(final String text,
      {final int? offset,
      final int? length,
      final int? startLine,
      final int? startColumn}) = _$_ExpectedText;
  _ExpectedText._() : super._();

  @override
  String get text;
  @override
  int? get offset;
  @override
  int? get length;
  @override
  int? get startLine;
  @override
  int? get startColumn;
  @override
  @JsonKey(ignore: true)
  _$$_ExpectedTextCopyWith<_$_ExpectedText> get copyWith =>
      throw _privateConstructorUsedError;
}
