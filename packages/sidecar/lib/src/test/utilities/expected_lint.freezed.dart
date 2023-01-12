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
      _$ExpectedLintCopyWithImpl<$Res, ExpectedLint>;
  @useResult
  $Res call({RuleCode code, int offset, int length});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class _$ExpectedLintCopyWithImpl<$Res, $Val extends ExpectedLint>
    implements $ExpectedLintCopyWith<$Res> {
  _$ExpectedLintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? offset = null,
    Object? length = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$_ExpectedLintCopyWith<$Res>
    implements $ExpectedLintCopyWith<$Res> {
  factory _$$_ExpectedLintCopyWith(
          _$_ExpectedLint value, $Res Function(_$_ExpectedLint) then) =
      __$$_ExpectedLintCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RuleCode code, int offset, int length});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$_ExpectedLintCopyWithImpl<$Res>
    extends _$ExpectedLintCopyWithImpl<$Res, _$_ExpectedLint>
    implements _$$_ExpectedLintCopyWith<$Res> {
  __$$_ExpectedLintCopyWithImpl(
      _$_ExpectedLint _value, $Res Function(_$_ExpectedLint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? offset = null,
    Object? length = null,
  }) {
    return _then(_$_ExpectedLint(
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      null == length
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
            (identical(other.code, code) || other.code == code) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.length, length) || other.length == length));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, offset, length);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      _$ExpectedTextCopyWithImpl<$Res, ExpectedText>;
  @useResult
  $Res call(
      {String text,
      int? offset,
      int? length,
      int? startLine,
      int? startColumn});
}

/// @nodoc
class _$ExpectedTextCopyWithImpl<$Res, $Val extends ExpectedText>
    implements $ExpectedTextCopyWith<$Res> {
  _$ExpectedTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? offset = freezed,
    Object? length = freezed,
    Object? startLine = freezed,
    Object? startColumn = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      startLine: freezed == startLine
          ? _value.startLine
          : startLine // ignore: cast_nullable_to_non_nullable
              as int?,
      startColumn: freezed == startColumn
          ? _value.startColumn
          : startColumn // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpectedTextCopyWith<$Res>
    implements $ExpectedTextCopyWith<$Res> {
  factory _$$_ExpectedTextCopyWith(
          _$_ExpectedText value, $Res Function(_$_ExpectedText) then) =
      __$$_ExpectedTextCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text,
      int? offset,
      int? length,
      int? startLine,
      int? startColumn});
}

/// @nodoc
class __$$_ExpectedTextCopyWithImpl<$Res>
    extends _$ExpectedTextCopyWithImpl<$Res, _$_ExpectedText>
    implements _$$_ExpectedTextCopyWith<$Res> {
  __$$_ExpectedTextCopyWithImpl(
      _$_ExpectedText _value, $Res Function(_$_ExpectedText) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? offset = freezed,
    Object? length = freezed,
    Object? startLine = freezed,
    Object? startColumn = freezed,
  }) {
    return _then(_$_ExpectedText(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      startLine: freezed == startLine
          ? _value.startLine
          : startLine // ignore: cast_nullable_to_non_nullable
              as int?,
      startColumn: freezed == startColumn
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
            (identical(other.text, text) || other.text == text) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.startLine, startLine) ||
                other.startLine == startLine) &&
            (identical(other.startColumn, startColumn) ||
                other.startColumn == startColumn));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, text, offset, length, startLine, startColumn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
